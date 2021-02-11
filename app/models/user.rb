class User

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