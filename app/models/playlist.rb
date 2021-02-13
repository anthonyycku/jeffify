class Playlist < ApplicationRecord
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

      def self.index(id)
        results = DB.exec(
            <<-SQL
                SELECT * FROM playlists
                WHERE id=#{id}
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "name" => results.first["name"]
        }
      end

      def self.create(opts)
        results = DB.exec(
            <<-SQL
                INSERT INTO playlists (name, user_id)
                VALUES ('#{opts["name"]}', #{opts["user_id"]})
                RETURNING id, name, user_id
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "name" => results.first["name"],
            "user_id" => results.first["user_id"].to_i
        }
      end

      def self.specific(id)
        results = DB.exec(
            <<-SQL
                SELECT
                playlists.id as "playlistID",
                playlists.name as "playlistName",
                users.username as "user_name"
                FROM playlists
                LEFT JOIN users
                ON playlists.user_id=users.id
                WHERE users.id=#{id}
            SQL
        )
        return results.map do |result|
            {
                "id" => result["playlistID"].to_i,
                "user" => result["user_name"],
                "playlistName" => result["playlistName"]
            }
        end
      end

      def self.addtoplaylist(songID, playlistID)
        results=DB.exec(
            <<-SQL
            INSERT INTO userplaylists (song_id, playlist_id)
            VALUES (#{songID}, #{playlistID})
            RETURNING id, song_id, playlist_id
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "song_id" => results.first["song_id"].to_i,
            "playlist_id" => results.first["playlist_id"].to_i
        }
      end

      def self.delete(id)
        results=DB.exec(
            <<-SQL
            DELETE FROM playlists
            WHERE id=#{id}
            SQL
        )
      end

      def self.playlistsongs(id)
        results=DB.exec(
            <<-SQL
            SELECT
            songs.id as "songID",
            songs.name as "songName",
            songs.audio as "songAudio",
            albums.name as "albumName",
            albums.image as "albumImage",
            artists.name as "artistName"
            FROM userplaylists
            LEFT JOIN songs ON userplaylists.song_id=songs.id
            LEFT JOIN playlists ON userplaylists.playlist_id=playlists.id
            LEFT JOIN albums ON songs.album_id=albums.id
            LEFT JOIN artists ON songs.artist_id=artists.id
            WHERE playlists.id=#{id}
            SQL
        )
        return results.map do |result|
            {
                "id" => result["songID"].to_i,
                "song" => result["songName"],
                "audio"=> result["songAudio"],
                "album" => result["albumName"],
                "image" => result["albumImage"],
                "artist" => result["artistName"]
            }
        end
      end
end