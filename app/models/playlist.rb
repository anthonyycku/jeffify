class Playlist
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

      def self.create(opts)
        results = DB.exec(
            <<-SQL
                INSERT INTO playlists (name, user_id)
                VALUES ('opts["name"]', opts["user_id"])
                RETURNING id, name, user_id
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "name" => results.first["name"],
            "user_id" => results.first["user_id"].to_i
        }
      end
end