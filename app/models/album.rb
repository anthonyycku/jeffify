class Album < ApplicationRecord
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

    def self.all
      results = DB.exec(
          <<-SQL
            SELECT 
            albums.name as "albumName",
            albums.image as "albumImage",
            albums.id as "albumID",
            artists.id as "artistID",
            artists.name as "albumArtist"
            FROM albums
            LEFT JOIN artists
            ON artists.id = albums.artist_id
            ORDER BY albums.name='Death of a Bachelor' DESC,
            albums.name='Overexposed' DESC, albums.id DESC
          SQL
      )
      return results.map do |result|
        {
            "id" => result["albumID"].to_i,
            "artist" => result["albumArtist"],
            "name" => result["albumName"],
            "image" => result["albumImage"],
            "artistID" => result["artistID"].to_i
        }
      end
    end

    def self.find(id)
      results = DB.exec(
        <<-SQL
          SELECT albums.*,
          artists.name as "artistName",
          artists.id as "artistID"
          FROM albums
          LEFT JOIN artists
          ON albums.artist_id=artists.id
          WHERE albums.id=#{id}
        SQL
      )
      result = results.first
    return {
        "id" => result["artistID"].to_i,
        "name" => result["name"],
        "artist" => result["artistName"],
        "image" => result["image"],
        "year" => result["year"]
      }
    end

    def self.queue(id)
      results = DB.exec(
        <<-SQL
        SELECT songs.audio, songs.name as "songName",
        albums.name as "albumName",
        albums.image as "albumImage",
        artists.name as "artistName"
        FROM songs
        LEFT JOIN albums
        ON albums.id=songs.album_id
        LEFT JOIN artists
        ON songs.artist_id=artists.id
        WHERE albums.id=#{id}
        SQL
      )
      return results.map do |result|
        {
          "song" => result["songName"],
          "album" => result["albumName"],
          "image" => result["albumImage"],
          "artist" => result["artistName"],
          "audio" => result["audio"]
      }
      end

    end

    def self.findAlbum(id)
      results = DB.exec(
        <<-SQL
        SELECT albums.* FROM albums
        LEFT JOIN artists
        ON albums.artist_id=artists.id
        WHERE artists.id=#{id}
        SQL
      )
      return results.map do |result|
        {
          "id" => result["id"].to_i,
          "name" => result["name"],
          "image" => result["image"],
          "artistID" => result["artist_id"]
        }
      end
    end

end
