class Playlist < ApplicationRecord
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

      def self.index
        results = DB.exec(
            <<-SQL
                SELECT * FROM playlists
            SQL
        )
        return results.map do |result|
            {
            "id" => result["id"].to_i,
            "name" => result["name"],
            "user_id" => result["user_id"].to_i
        }
        end
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
                "user" => result["user_name"],
                "playlistName" => result["playlistName"]
            }
        end
      end
end