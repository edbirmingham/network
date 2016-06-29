# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Location.create(name: 'Tuggle Elementary')
Location.create(name: 'Carver High School')
Location.create(name: 'Hudson K-8')
Location.create(name: 'Ramsay High School')

Member.create(
  first_name: 'Victoria', 
  last_name: 'Hollis',
  email: 'victoria@example.com',
  phone: '205 999-9999'
)
Member.create(
  first_name: 'Chris', 
  last_name: 'Collins',
  email: 'chris@example.com',
  phone: '205 999-9999'
)
Member.create(
  first_name: 'Andrew', 
  last_name: 'Sellers',
  email: 'andrew@example.com',
  phone: '205 999-9999'
)
Member.create(
  first_name: 'Sean', 
  last_name: 'Abdoli',
  email: 'sean@example.com',
  phone: '205 999-9999'
)

Program.create(name: 'College 101')
Program.create(name: 'Raise Up Initiatives')
Program.create(name: 'Educator Round Table')
Program.create(name: 'Connector Table Meeting')
Program.create(name: 'Core Team Meeting')

User.create(email: 'jane.doe@example.com', password: 'password')
User.create(email: 'john.doe@example.com', password: 'password')

Location.all.each do |location|
  Program.all.each do |program|
    NetworkEvent.create(
      name: "#{location.name} #{program.name}",
      program: program,
      location: location,
      scheduled_at: rand(14).days.from_now
    )
  end
end