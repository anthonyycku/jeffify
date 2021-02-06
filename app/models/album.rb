class Album
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

    self.allAlbums
      results = DB.exec(
          <<-SQL
            SELECT 
            albums.name as "albumName",
            albums.artist as "albumArtist",
            albums.id as "albumID"
            FROM albums
          SQL
      )
      return results.map do |result|
        {
            "id" => result["albumID"],
            "artist" => result["albumArtist"],
            "name" => result["albumName"]
        }
      end
    end

end