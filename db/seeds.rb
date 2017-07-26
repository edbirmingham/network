# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create(
  email: 'jane.doe@example.com', 
  password: 'password', 
  admin: true
)
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

gear_up = Cohort.create(name: 'Gear-Up', user_id: user.id)
health_academy = Cohort.create(name: 'Academy of Health Sciences', user_id: user.id)
educator_academy = Cohort.create(name: 'Academy of Urban Educators', user_id: user.id)

marching_band = ExtracurricularActivity.create(name: 'Marching Band', user_id: user.id)
football = ExtracurricularActivity.create(name: 'Football', user_id: user.id)
chess_club = ExtracurricularActivity.create(name: 'Chess Club', user_id: user.id)
theater = ExtracurricularActivity.create(name: 'Theater', user_id: user.id)


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

carver = School.create(name: 'Carver High School', user_id: user.id)
tuggle = School.create(name: 'Tuggle Elementary School', user_id: user.id)
hudson = School.create(name: 'Hudson K-8', user_id: user.id)
ramsey = School.create(name: 'Ramsey High School', user_id: user.id)
school_choice = [carver, tuggle, hudson, ramsey]

victoria = Member.create(
  first_name: 'Victoria',
  last_name: 'Hollis',
  email: 'victoria@example.com',
  phone: '205 999-9999',
  neighborhoods: [roebuck],
  cohorts: [gear_up],
  school: carver,
  user_id: user.id
)
chris = Member.create(
  first_name: 'Chris',
  last_name: 'Collins',
  email: 'chris@example.com',
  phone: '205 999-9999',
  neighborhoods: [smithfield,ensley],
  cohorts: [health_academy],
  school: carver,
  user_id: user.id
)
andrew = Member.create(
  first_name: 'Andrew',
  last_name: 'Sellers',
  email: 'andrew@example.com',
  phone: '205 999-9999',
  neighborhoods: [woodlawn],
  cohorts: [health_academy, gear_up],
  school: hudson,
  user_id: user.id
)
sean = Member.create(
  first_name: 'Sean',
  last_name: 'Abdoli',
  email: 'sean@example.com',
  phone: '205 999-9999',
  neighborhoods: [ensley],
  cohorts: [educator_academy],
  school: ramsey,
  user_id: user.id
)

Program.create(name: 'College 101', user_id: user.id)
Program.create(name: 'Raise Up Initiatives', user_id: user.id)
Program.create(name: 'Educator Round Table', user_id: user.id)
Program.create(name: 'Connector Table Meeting', user_id: user.id)
Program.create(name: 'Core Team Meeting', user_id: user.id)

eab = Organization.create(name: 'EAB', created_by_id: user.id)
regions = Organization.create(name: 'Regions Bank', created_by_id: user.id)
publix = Organization.create(name: 'Publix', created_by_id: user.id)
code = Organization.create(name: 'Code for Birmingham', created_by_id: user.id)
chamber = Organization.create(name: 'Birmingham Chamber of Commerce', created_by_id: user.id)
organizations = [eab, regions, publix, code, chamber]

Talent.create(name: 'Arts', user_id: user.id)
Talent.create(name: 'Math', user_id: user.id)
Talent.create(name: 'Technology', user_id: user.id)
Talent.create(name: 'Music', user_id: user.id)
Talent.create(name: 'Sports', user_id: user.id)

student_nell = Member.create(
  first_name: 'Nell',
  last_name: 'Student',
  email: 'nell@example.com',
  phone: '205 999-9999',
  neighborhoods: [ensley],
  school: carver,
  graduating_class: class_of_2017,
  cohorts: [gear_up],
  user_id: user.id
)

chaperone_task = CommonTask.create(name: 'Find X chaperones', user_id: user.id, date_modifier: 'Monday before event')
transportation_task = CommonTask.create(name: 'Schedule transportation', user_id: user.id, date_modifier: '1 week before event')
catering_task = CommonTask.create(name: 'Schedule catering', user_id: user.id, date_modifier: '1 month before event')

network_event = nil
Location.all.each do |location|
  Program.all.each do |program|
    network_event = NetworkEvent.create(
      name: "#{location.name} #{program.name}",
      program: program,
      location: location,
      organizations: organizations.sample(1),
      site_contacts: [sean, victoria],
      school_contacts: [chris],
      volunteers: [andrew],
      schools: school_choice.sample(2),
      graduating_classes: [class_of_2016, class_of_2017],
      cohorts: [gear_up],
      scheduled_at: rand(14).days.from_now,
      status: NetworkEvent.statuses.sample,
      user_id: user.id
    )
    network_event.network_event_tasks.create(
      name: "Schedule 4 buses",  
      owner_id: user.id,
      common_task_id: transportation_task.id,
      date_modifier: transportation_task.date_modifier
    )
    network_event.network_event_tasks.create(
      name: "Recruit 7 chaperones",  
      owner_id: user.id,
      common_task_id: chaperone_task.id,
      date_modifier: chaperone_task.date_modifier
    )
    network_event.network_event_tasks.create(
      name: "Schedule catering",  
      owner_id: user.id,
      common_task_id: catering_task.id,
      date_modifier: catering_task.date_modifier
    )
    network_event.apply_date_modifiers_to_tasks
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

Identity.create([
  {name: "Student"},
  {name: "Parent"},
  {name: "Educator"},
  {name: "Resident"},
  {name: "Community Partner"}
])

identity_enumerator = Identity.all.cycle

(1..99).each do |i|
  Member.create(
    first_name: "User#{i}",
    last_name: 'Crowd',
    email: "user#{i}_clone@example.com",
    phone: '205 555-5555',
    neighborhoods: [ensley],
    cohorts: [educator_academy],
    school: ramsey,
    user_id: user.id,
    identity: identity_enumerator.next
  )
end
