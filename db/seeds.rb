# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(email: 'jane.doe@example.com', password: 'password')

Program.create(name: 'College 101')
Program.create(name: 'Raise Up Initiatives')
Program.create(name: 'Educator Round Table')
Program.create(name: 'Connector Table Meeting')
Program.create(name: 'Core Team Meeting')