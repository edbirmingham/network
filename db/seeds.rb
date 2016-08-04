# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'jane.doe@example.com', password: 'password')
User.create(email: 'john.doe@example.com', password: 'password')

Location.create(
  name: 'Tuggle Elementary', 
  address_one: '1234 Broad St N', 
  city: 'Birmingham', 
  state: 'AL', 
  zip_code: '35204', 
  user_id: user.id
)
Location.create(
  name: 'Carver High School', 
  address_one: '3200 24th St N', 
  city: 'Birmingham', 
  state: 'AL', 
  zip_code: '35207', 
  user_id: user.id
)
Location.create(
  name: 'Hudson K-8', 
  address_one: '3300 F L Shuttlesworth Dr', 
  city: 'Birmingham', 
  state: 'AL', 
  zip_code: '35204', 
  user_id: user.id
)
Location.create(
  name: 'Ramsay High School', 
  address_one: '1800 13th Ave S', 
  city: 'Birmingham', 
  state: 'AL', 
  zip_code: '35205', 
  user_id: user.id
)

Member.create(
  first_name: 'Victoria', 
  last_name: 'Hollis',
  email: 'victoria@example.com',
  phone: '205 999-9999',
  user_id: user.id
)
Member.create(
  first_name: 'Chris', 
  last_name: 'Collins',
  email: 'chris@example.com',
  phone: '205 999-9999',
  user_id: user.id
)
Member.create(
  first_name: 'Andrew', 
  last_name: 'Sellers',
  email: 'andrew@example.com',
  phone: '205 999-9999',
  user_id: user.id
)
Member.create(
  first_name: 'Sean', 
  last_name: 'Abdoli',
  email: 'sean@example.com',
  phone: '205 999-9999',
  user_id: user.id
)

Program.create(name: 'College 101', user_id: user.id)
Program.create(name: 'Raise Up Initiatives', user_id: user.id)
Program.create(name: 'Educator Round Table', user_id: user.id)
Program.create(name: 'Connector Table Meeting', user_id: user.id)
Program.create(name: 'Core Team Meeting', user_id: user.id)

Organization.create(name: 'EAB', created_by_id: user.id)
Organization.create(name: 'Regions Bank', created_by_id: user.id)
Organization.create(name: 'Publix', created_by_id: user.id)
Organization.create(name: 'Code for Birmingham', created_by_id: user.id)
Organization.create(name: 'Birmingham Chamber of Commerce', created_by_id: user.id)

Location.all.each do |location|
  Program.all.each do |program|
    NetworkEvent.create(
      name: "#{location.name} #{program.name}",
      program: program,
      location: location,
      scheduled_at: rand(14).days.from_now,
      user_id: user.id
    )
  end
end