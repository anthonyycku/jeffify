class Album
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
            albums.artist as "albumArtist",
            albums.image as "albumImage",
            albums.id as "albumID"
            FROM albums
          SQL
      )
      return results.map do |result|
        {
            "id" => result["albumID"].to_i,
            "artist" => result["albumArtist"],
            "name" => result["albumName"],
            "image" => result["albumImage"]
        }
      end
    end

    def self.find(id)
      results = DB.exec(
        <<-SQL
          SELECT * FROM albums
          WHERE id=#{id}
        SQL
      )
    return results.map do |result|
      {
        "name" => results["name"],
        "artist" => results["artist"],
        "image" => results["image"]
      }
      end
    end
end