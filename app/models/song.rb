class Song
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

    def self.all
        results = DB.exec(
        <<-SQL    
        SELECT * FROM songs
        SQL
        )
        return results.map do |result|
          {

            "id" => result["id"].to_i,
            "name" => result["name"],
            "artist" => result["artist"],
            "album_id" => result["album_id"]
          }
        end
      end
      
      def self.specific(id)
        results = DB.exec(
          <<-SQL
          SELECT
          songs.name as "songName",
          songs.artist as "songArtist",
          albums.name as "albumName"
          FROM songs
          LEFT JOIN albums
          ON songs.album_id=albums.id
          WHERE album_id=#{id}
          SQL
        )
        return results.map do |result|
          {
            "name" => result["songName"],
            "artist" => result["songArtist"],
            "album" => result["albumName"]
          }
        end
      end

end