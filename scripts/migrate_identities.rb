# Install pg gem before running this script.
#
# Run this script with the following command:
#
# DATABASE_URL=$(heroku config:get DATABASE_URL -a ednetwork) irb scripts/migrate_identities.rb
#

require 'pg'

pg = PG::Connection.open(ENV["DATABASE_URL"])

pg.exec("UPDATE members SET identity_id=1 WHERE members.identity ='Student'")
pg.exec("UPDATE members SET identity_id=2 WHERE members.identity ='Parent'")
pg.exec("UPDATE members SET identity_id=3 WHERE members.identity ='Educator'")
pg.exec("UPDATE members SET identity_id=4 WHERE members.identity ='Resident'")
pg.exec("UPDATE members SET identity_id=5 WHERE members.identity ='Community\ Partner'")

