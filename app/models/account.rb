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
                "username" => result["username"],
                "password" => result["password"]
            }
        end
    end

    def self.create(username, password)
        results = DB.exec(
            <<-SQL
            INSERT INTO users (username, password)
            VALUES ('#{username}','#{password}')
            SQL
        )
        return {
            "username" => results.first["username"],
            "password" => results.first["password"]
        }
    end
end