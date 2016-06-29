# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'jane.doe@example.com', password: 'password')
User.create(email: 'john.doe@example.com', password: 'password')

Location.create(name: 'Tuggle Elementary', user_id: user.id)
Location.create(name: 'Carver High School', user_id: user.id)
Location.create(name: 'Hudson K-8', user_id: user.id)
Location.create(name: 'Ramsay High School', user_id: user.id)

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