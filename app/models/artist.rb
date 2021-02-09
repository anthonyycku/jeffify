class Artist
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

    def self.find(id)
    results = DB.exec(
        <<-SQL
        SELECT
        artists.name as "artistName",
        artists.image as "artistImage",
        FROM artists
        WHERE id=#{id}
        SQL
        )
        return {
            "name" => results.first["artistName"],
            "image" => results.first["artistImage"]
        }
      end

      # ALL
      def self.allsongs(id)
        results = DB.exec(
        <<-SQL
        SELECT
        songs.name as "songName",
        songs.audio as "audio",
        albums.name as "albumName",
        albums.image as "albumImage",
        albums.year as "albumYear",
        artists.name as "artistName"
        FROM songs
        INNER JOIN artists
        ON songs.artist_id=artists.id
        INNER JOIN albums
        ON albums.id=songs.album_id
        WHERE artists.id=#{id}
        SQL
        )
        return results.map do |result|
            {
                "song" => result["songName"],
                "audio" => result["audio"],
                "album" => result["albumName"],
                "image" => result["albumImage"],
                "artist" => result["artistName"],
                "year" => result["albumYear"]
            }
        end
    end
end

