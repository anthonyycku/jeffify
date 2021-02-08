class Artist < ApplicationRecord
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
                artists.image as "artistImage"
                FROM artists
                WHERE id=#{id}
            SQL
        )
        return {
            "name" => results.first["artistName"],
            "image" => results.first["artistImage"]
        }
      end
end