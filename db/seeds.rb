# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(email: 'jane.doe@example.com', password: 'password')
User.create(email: 'john.doe@example.com', password: 'password')

class_of_2016 = GraduatingClass.create(year: 2016, user_id: user.id)
class_of_2017 = GraduatingClass.create(year: 2017, user_id: user.id)
GraduatingClass.create(year: 2018, user_id: user.id)
GraduatingClass.create(year: 2019, user_id: user.id)
GraduatingClass.create(year: 2020, user_id: user.id)

roebuck = Neighborhood.create(name: 'Roebuck', user_id: user.id)
smithfield = Neighborhood.create(name: 'Smithfield', user_id: user.id)
woodlawn = Neighborhood.create(name: 'Woodlawn', user_id: user.id)
ensley = Neighborhood.create(name: 'Ensley', user_id: user.id)

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

victoria = Member.create(
  first_name: 'Victoria',
  last_name: 'Hollis',
  email: 'victoria@example.com',
  phone: '205 999-9999',
  neighborhoods: [roebuck],
  user_id: user.id
)
chris = Member.create(
  first_name: 'Chris',
  last_name: 'Collins',
  email: 'chris@example.com',
  phone: '205 999-9999',
  neighborhoods: [smithfield,ensley],
  user_id: user.id
)
andrew = Member.create(
  first_name: 'Andrew',
  last_name: 'Sellers',
  email: 'andrew@example.com',
  phone: '205 999-9999',
  neighborhoods: [woodlawn],
  user_id: user.id
)
sean = Member.create(
  first_name: 'Sean',
  last_name: 'Abdoli',
  email: 'sean@example.com',
  phone: '205 999-9999',
  neighborhoods: [ensley],
  user_id: user.id
)

Program.create(name: 'College 101', user_id: user.id)
Program.create(name: 'Raise Up Initiatives', user_id: user.id)
Program.create(name: 'Educator Round Table', user_id: user.id)
Program.create(name: 'Connector Table Meeting', user_id: user.id)
Program.create(name: 'Core Team Meeting', user_id: user.id)

eab = Organization.create(name: 'EAB', created_by_id: user.id)
Organization.create(name: 'Regions Bank', created_by_id: user.id)
Organization.create(name: 'Publix', created_by_id: user.id)
Organization.create(name: 'Code for Birmingham', created_by_id: user.id)
Organization.create(name: 'Birmingham Chamber of Commerce', created_by_id: user.id)

gear_up = Cohort.create(name: 'Gear-Up', user_id: user.id)
health_academy = Cohort.create(name: 'Academy of Health Sciences', user_id: user.id)
educator_academy = Cohort.create(name: 'Academy of Urban Educators', user_id: user.id)

carver = School.create(name: 'Carver High School', user_id: user.id)
tuggle = School.create(name: 'Tuggle Elementary School', user_id: user.id)

Talent.create(name: 'Arts', user_id: user.id)
Talent.create(name: 'Math', user_id: user.id)
Talent.create(name: 'Technology', user_id: user.id)
Talent.create(name: 'Music', user_id: user.id)
Talent.create(name: 'Sports', user_id: user.id)

network_event = nil
Location.all.each do |location|
  Program.all.each do |program|
    network_event = NetworkEvent.create(
      name: "#{location.name} #{program.name}",
      program: program,
      location: location,
      organizations: [eab],
      site_contacts: [sean, victoria],
      school_contacts: [chris],
      volunteers: [andrew],
      schools: [carver, tuggle],
      graduating_classes: [class_of_2016, class_of_2017],
      cohorts: [gear_up],
      scheduled_at: rand(14).days.from_now,
      user_id: user.id
    )
  end
end

network_action = NetworkAction.create(
  network_event: network_event,
  actor: victoria,
  action_type: 'Offer',
  description: 'Need chaperones for College 101 at UAB.',
  members: [sean, andrew],
  user: user
)

Talent.create(
  name: 'Arts',
  user: user
)

Talent.create(
  name: 'Math',
  user: user
)

Talent.create(
  name: 'Technology',
  user: user
)

Participation.create(
  level: 'attendee',
  member: sean,
  network_event: network_event
)

Participation.create(
  level: 'volunteer',
  member: victoria,
  network_event: network_event
)
