class Song < ApplicationRecord
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

    def self.all
        results = DB.exec(
        <<-SQL    
        SELECT songs.*,
        artists.name as "artistName"
        FROM songs
        INNER JOIN artists
        ON songs.artist_id=artists.id
        SQL
        )
        return results.map do |result|
          {

            "id" => result["id"].to_i,
            "name" => result["name"],
            "artist" => result["artistName"],
            "album_id" => result["album_id"],
            "audio" => result["audio"]
          }
        end
      end
      
      def self.specific(id)
        results = DB.exec(
          <<-SQL
          SELECT
          songs.name as "songName",
          songs.audio,
          albums.name as "albumName",
          albums.image,
          artists.name as "artistName"
          FROM songs
          LEFT JOIN albums
          ON songs.album_id=albums.id
          LEFT JOIN artists
          ON artists.id=songs.artist_id
          WHERE album_id=#{id}
          SQL
        )
        return results.map do |result|
          {
            "name" => result["songName"],
            "audio"=>result["audio"],
            "album" => result["albumName"],
            "albumImage" => result["albumImage"],
            "artist" => result["artistName"]
          }
        end
      end

end