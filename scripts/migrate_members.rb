# Install pg and mongo gems before running this script.
#
# Run this script with the following command:
#
# DATABASE_URL=$(heroku config:get DATABASE_URL -a ednetwork) MONGOHQ_URL=$(heroku config:get MONGOHQ_URL -a ednetwork) irb scripts/migrate_members.rb
#

require 'pg'
require 'mongo'

pg = PG::Connection.open(ENV["DATABASE_URL"])

resp = pg.exec("SELECT * FROM members")

mongo = Mongo::Client.new(ENV["MONGOHQ_URL"])
db = mongo.database
db[:participants].find.each do |participant|
    
    resp = pg.exec("SELECT * FROM members WHERE mongo_id = '#{participant["_id"]}'")
    if resp.count == 0
        puts participant
        insert = <<-SQL
            INSERT INTO members 
            (first_name, last_name, phone, email, identity, mongo_id, created_at, updated_at)
            VALUES
            ($1, $2, $3, $4, $5, $6, $7, $8)
        SQL
        params = [
            participant[:firstName], 
            participant[:lastName], 
            participant[:phone], 
            participant[:email],
            participant[:identity],
            participant["_id"].to_s,
            participant[:created],
            participant[:created]
        ]
        pg.exec_params(insert, params)
    else
        puts resp.to_a
    end
end