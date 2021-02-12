class Account < ApplicationRecord
    if(ENV['DATABASE_URL'])
        uri = URI.parse(ENV['DATABASE_URL'])
        DB = PG.connect(uri.hostname, uri.port, nil, nil, uri.path[1..-1], uri.user, uri.password)
      else
        DB = PG.connect(host: "localhost", port: 5432, dbname: 'jeffify_development')
      end

    def self.index
        results = DB.exec(
            <<-SQL
            SELECT * FROM users
            SQL
        )
        return results.map do |result|
            {
                "id"=> result["id"].to_i,
                "username" => result["username"],
                "password" => result["password"]
            }
        end
    end

    def self.create(opts)
        results = DB.exec(
            <<-SQL
            INSERT INTO users (username, password)
            VALUES ('#{opts["username"]}','#{opts["password"]}')
            RETURNING id, username
            SQL
        )
        return {
            "id"=>results.first["id"].to_i,
            "username" => results.first["username"]
        }
    end

    def self.getrecent
        results = DB.exec(
            <<-SQL
            SELECT * FROM users
            ORDER BY id DESC
            SQL
        )
        return {
            "id" => results.first["id"].to_i,
            "username" => results.first["username"]
        }
    end
end