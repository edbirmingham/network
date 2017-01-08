require 'csv'
require 'set'
require 'pp'

def member_lookup(members, member)
    members[member] || 
        Member.search(member).first.try(:id) || 
        Member.create!(
            first_name: member.split(' ')[0..-2].join(' '),
            last_name: member.split(' ').last,
            identity: 'Educator'
        ).id
end

def organization_lookup(organizations, organization)
    organizations[organization] || 
        Organization.where(Organization.arel_table[:name].matches("#{organization}%")).first.try(:id) ||
        Organization.create!(name: organization).id
end

def location_lookup(locations, location)
    locations[location] || 
        Location.where(name: location).first.try(:id) || 
        Location.create!(name: location).id
end

def cohort_lookup(cohorts, cohort)
    cohorts[cohort] ||
        Cohort.where(name: cohort).first.try(:id) ||
        Cohort.create!(name: cohort).id
end

def all_cohorts(cohorts, cohort, classroom)
    all = []
    if cohort.present?
        all += cohort.try(:split, ', ').try(:map){|c| cohort_lookup(cohorts, c)}
    end
    if classroom.present?
        all += classroom.try(:split, ', ').try(:map){|c| cohort_lookup(cohorts, c)}
    end
    all.compact.uniq
end

if Rails.env.production?
    organizations = {
        "UAB" => 86   
    }
    
    cohorts = {
       "Educate Local" => 14, 
       "GUB" => 3, 
       "AOE" => 6, 
       "AOHS" => 7, 
       "AOAC" => 4, 
       "AOUE" => 10, 
       "AOHT" => 11, 
       "AOBF" => 2,
       "SCM" => 15, 
       "AOIT" => 1, 
       "HS" => 16
    }
    
    graduating_classes = {
        "2022" => 7, 
        "2021" => 6, 
        "2020" => 5, 
        "2019" => 3, 
        "2018" => 2, 
        "2017" => 1,
        "7"=>7, 
        "8"=>6, 
        "10"=>3, 
        "11"=>2, 
        "12"=>1, 
        "9"=>5, 
        "--"=>nil, 
        "K-5"=>15, 
        "12-Sep"=>nil, 
        "8-Jun"=>nil, 
        nil=>nil, 
        "3"=>12, 
        "5"=>10, 
        "2"=>13, 
        "1"=>14, 
        "4"=>11
    }
    
    locations = {
        "WJ Christian K-8"=>10, 
        "Phillips Academy"=>14, 
        "Wylam K-8"=>11, 
        "Carver HS"=>1, 
        "Huffman HS"=>7, 
        "Ramsay HS"=>5, 
        "Woodlawn HS"=>6, 
        "Ossie Ware MS"=>9, 
        "Parker HS"=>2, 
        "Wenonah HS"=>3, 
        "Jackson-Olin HS"=>4, 
        "Huffman MS"=>8, 
        "Hudson K-8"=>12, 
        "Oliver Elementary"=>16, 
        "Tuggle Elementary"=>15, 
        "Wilkerson MS"=>13 
    }
    
    programs = {
        "EL"=>7, 
        "CDC"=>1, 
        "BTG"=>2, 
        "NN"=>5, 
        "SCM"=>4, 
        "C101"=>3    
    }
    
    schools = {
        "Hudson K-8" => 12, 
        "Huffman MS" => 8, 
        "Ossie Ware MS" => 13, 
        "Phillips Academy" => 15, 
        "Wilkerson MS" => 10, 
        "WJ Christan K-8" => 14, 
        "Wylam K-8" => 9, 
        "WJ Christian K-8" => 14, 
        "Carver HS" => 6, 
        "Huffman HS" => 7, 
        "Jackson-Olin HS" => 4, 
        "Parker HS" => 5, 
        "Ramsay HS" => 1, 
        "Wenonah HS" => 3, 
        "Woodlawn HS" => 2,
        "Tuggle Elementary" => 11, 
        "Wenonah" => 3, 
        "Woodlawn" => 2, 
        "Jackson-Olin" => 4, 
        "Parker" => 5, 
        "Ramsay" => 1, 
        "Ossie-Ware" => 13, 
        "Ossie-Ware MS" => 13,
        "Wylam" => 9, 
        "Wilkerson" => 10, 
        "WJ Christian" => 14, 
        "Phillips" => 15, 
        "Oliver ES" => 16
    }
    
    members = {
        "Phylecia Ragland"=>4017,
        "JohnMark Edwards"=>4018,
        "Nefertari Yancie"=>4019,
        "Sandy Moore"=>4020,
        "Lindsey Bloodworth"=>14,
        "Vanessa Jones"=>4021,
        "Elliot Ashley"=>4022,
        "Amanda Dubois"=>4023,
        "Amanda DuBois"=>4023,
        "Mia Ward"=>4024,
        "Jessica Wedgeworth"=>4025,
        "Allison Kelly"=>4026,
        "Cameron Shevlin"=>4027,
        "David Liddell"=>1256,
        "Cathareene Burrell"=>1001,
        "Brittany Seay"=>4028,
        "Cassandra Ellis"=>4029,
        "Kristie Williams"=>1741,
        "Claire Finney"=>4030,
        "Rebecca Brown"=>4031,
        "Jessica Atkins"=>4032,
        "Finnisse Williams"=>4033,
        "Akya Rice"=>4034,
        "Malcolm Griggs"=>1042,
        "Shirley Fagan"=>4035,
        "Dorothy Gibson"=>4036,
        "Cindy Fisher Crawford"=>4037,
        "April Reis"=>4038
    }
else
    organizations = {
    }
    
    cohorts = {
       "GUB" => 1, 
       "AOE" => 3, 
       "AOHS" => 2, 
       "AOAC" => 3, 
       "AOUE" => 3, 
       "AOHT" => 3, 
       "AOBF" => 3,
       "SCM"=>3, 
       "AOIT"=>3, 
       "HS"=>3
    }
    
    graduating_classes = {
        "2022" => 5, 
        "2021" => 5, 
        "2020" => 5, 
        "2019" => 4, 
        "2018" => 3, 
        "2017" => 2,
        "7"=>5, 
        "8"=>5, 
        "10"=>4, 
        "11"=>3, 
        "12"=>2, 
        "9"=>5, 
        "--"=>nil, 
        "K-5"=>5, 
        "12-Sep"=>nil, 
        "8-Jun"=>nil, 
        nil=>nil, 
        "3"=>5, 
        "5"=>5, 
        "2"=>5, 
        "1"=>5, 
        "4"=>5
    }
    
    locations = {
        "Carver HS"=>2, 
        "Ramsay HS"=>4, 
        "Hudson K-8"=>3, 
        "Tuggle Elementary"=>1
    }
    
    programs = {
        "EL"=>2, 
        "CDC"=>2, 
        "BTG"=>3, 
        "NN"=>5, 
        "SCM"=>4, 
        "C101"=>1    
    }
    
    schools = {
        "Hudson K-8" => 3, 
        "Huffman MS" => 2, 
        "Ossie Ware MS" => 2, 
        "Phillips Academy" => 2, 
        "Wilkerson MS" => 2, 
        "WJ Christan K-8" => 2, 
        "Wylam K-8" => 2, 
        "WJ Christian K-8" => 2, 
        "Carver HS" => 1, 
        "Huffman HS" => 2, 
        "Jackson-Olin HS" => 2, 
        "Parker HS" => 2, 
        "Ramsay HS" => 4, 
        "Wenonah HS" => 2, 
        "Woodlawn HS" => 2,
        "Tuggle Elementary"=>2, 
        "Wenonah"=>2, 
        "Woodlawn"=>2, 
        "Jackson-Olin"=>2, 
        "Parker"=>2, 
        "Ramsay"=>4, 
        "Ossie-Ware"=>2, 
        "Ossie-Ware MS"=>2,
        "Wylam"=>2, 
        "Wilkerson"=>2, 
        "WJ Christian"=>2, 
        "Phillips"=>2, 
        "Oliver ES"=>2
    }
    
    members = {
        "Phylecia Ragland"=>1,
        "JohnMark Edwards"=>1,
        "Nefertari Yancie"=>1,
        "Sandy Moore"=>1,
        "Lindsey Bloodworth"=>1,
        "Vanessa Jones"=>1,
        "Elliot Ashley"=>1,
        "Amanda Dubois"=>1,
        "Amanda DuBois"=>1,
        "Mia Ward"=>1,
        "Jessica Wedgeworth"=>1,
        "Allison Kelly"=>1,
        "Cameron Shevlin"=>1,
        "David Liddell"=>1,
        "Cathareene Burrell"=>1,
        "Brittany Seay"=>1,
        "Cassandra Ellis"=>1,
        "Kristie Williams"=>1,
        "Claire Finney"=>1,
        "Rebecca Brown"=>1,
        "Jessica Atkins"=>1,
        "Finnisse Williams"=>1,
        "Akya Rice"=>1,
        "Malcolm Griggs"=>1,
        "Shirley Fagan"=>1,
        "Dorothy Gibson"=>1,
        "Cindy Fisher Crawford"=>1,
        "April Reis"=>1,
        "Tammie Dodson"=>1,
        "Deborah Blaylock"=>1,
        "Janna Bradt"=>1,
        "Dr. Ellis"=>1,
        "Allison Kelley"=>1,
        "Brandon Price"=>1,
        "Danielle Hines"=>1,
        "Nneka Gunn"=>1,
        "Jasmine Baldwin"=>1,
        "Mellissa Hyche"=>1,
        "Renee Browning"=>1,
        "ASF"=>1,
        "Rachel Flint"=>1,
        "Melissa Morgan"=>1,
        "Ethelyn Willis"=>1,
        "Faye Oates"=>1,
        "Courtney Ready"=>1,
        "Brent Gilley"=>1,
        "T. Marie King"=>1,
        "Katie Clements"=>1,
        "Ashley Culliver"=>1,
        "Melissa Cottrell"=>1,
        "Jared Danks"=>1,
        "Melissa Hyche"=>1,
        "Stacia Gaines"=>1,
        "Matthew Smith"=>1,
        "Bill Miller"=>1,
        "Natasha Rembert"=>1,
        "Elma Bell"=>1,
        "Rebekah Elgin-Council"=>1,
        "Jessica Coates"=>1,
        "Jody Mattson"=>1,
        "Kathleen Hamrick"=>1,
        "Monica Drake"=>1,
        "John Stone"=>1,
        "Allison Cambre"=>1,
        "Sarah Silverstein"=>1,
        "Toni Herrera-Bhast"=>1,
        "Mel Snider"=>1,
        "Leslie Scarborough"=>1,
        "Ryan Robinett"=>1,
        "Crawford Miller"=>1,
        "Lawrence Cooper"=>1,
        "Denise Gregory"=>1,
        "Kinsley Foster"=>1,
        "Bruce Lanier"=>1,
        "Amy Morgan"=>1,
        "Deon Gordon"=>1,
        "Denise Lynch"=>1,
        "Matthew Stokes"=>1,
        "Whitney Williams"=>1,
        "Alma Bell"=>1,
        "Bryan Jones"=>1,
        "Lea Ann Macknally"=>1,
        "Ryan Collins"=>1,
        "Ahmad Ward"=>1,
        "Miles Nerud"=>1,
        "Dixon Barth"=>1,
        "Abi Yildrim"=>1,
        "ECE Department"=>1,
        "Lee Ann Petty"=>1,
        "Jason Langford"=>1,
        "Mrs. Williams"=>1,
        "Mrs. Drew"=>1,
        "Mrs. Montgomery"=>1,
        "Selena Florence"=>1
    }
end

values = Set.new
missing = Set.new

index = 1
CSV.foreach("tmp/calendar.csv", headers: true) do |row|
    if row["Event Name"].present?
        index += 1
        puts index
        
        scheduled_at = Time.strptime("#{row["Date"]}", "%m/%d/%y") rescue nil
        scheduled_at = Time.strptime("#{row["Date"]} #{row["Start time"]}", "%m/%d/%y %H:%M %p") rescue scheduled_at
        scheduled_at ||= Time.now + 6.months
        
        scheduled_end = Time.strptime("#{row["Date"]}", "%m/%d/%y") rescue nil
        scheduled_end = Time.strptime("#{row["Date"]} #{row["End time"]}", "%m/%d/%y %H:%M %p") rescue scheduled_end
        scheduled_end ||= Time.now + 6.months + 60.minutes
        
        scheduled_duration = (scheduled_end - scheduled_at)/1.minutes
        
        NetworkEvent.create!(
            name: row["Event Name"],
            status: row["Status"],
            school_ids: row["School"].try(:split, ', ').try(:map){|s| schools[s]},
            cohort_ids: all_cohorts(cohorts, row["Cohort"], row["Classroom"]),
            school_contact_ids: row["Host Contact"].try(:split, ', ').try(:map){|h| member_lookup(members, h)},
            volunteer_ids: row["Presenter"].try(:split, ', ').try(:map){|h| member_lookup(members, h)},
            graduating_class_ids: row["Grade"].try(:split, ', ').try(:map){|g| graduating_classes[g]},
            organization_ids: row["Organization"].try(:split, ', ').try(:map){|o| organization_lookup(organizations, o)},
            program_id: programs[row["Program"]],
            location_id: location_lookup(locations, row["Location"]),
            scheduled_at: scheduled_at,
            duration: scheduled_duration,
            mongo_id: "csv.calendar.#{index}"
        )
        # row["School"].try(:split, ', ').try(:each) do |school|
        #     values.add school
        #     missing.add school if schools[school].blank?
        # end
        # puts row["School"] if schools[row["School"]].blank?
        # values.add row["Graduating Class"].split('-').last
        # puts row["Graduating Class"].split('-').last if graduating_classes[row["Graduating Class"].split('-').last].blank?
        # row["Grade"].try(:split, ', ').try(:each) do |grade|
        #     values.add row[grade]
        #     missing.add row[grade] if graduating_classes[grade].blank?
        # end
        # row["Cohort"].try(:split, ', ').try(:each) do |cohort|
        #     values.add cohort
        #     missing.add cohort if cohorts[cohort].blank?
        # end
        # row["Classroom"].try(:split, ', ').try(:each) do |classroom|
        #     values.add classroom
        #     missing.add classroom if cohorts[classroom].blank?
        # end
        # row["Host Contact"].try(:split, ', ').try(:each) do |host|
        #     values.add host
        #     missing.add host if members[host].blank?
        # end
        # row["Presenter"].try(:split, ', ').try(:each) do |presenter|
        #     values.add presenter
        #     missing.add presenter if members[presenter].blank?
        # end
        # row["Organization"].try(:split, ', ').try(:each) do |organization|
        #     values.add organization
        #     missing.add organization if organizations[organization].blank?
        # end
        # puts row["Cohort"] if cohorts[row["Cohort"]].blank?
        # values.add row["Program"]
        # missing.add row["Program"] if programs[row["Program"]].blank?
        # values.add row["Location"]
        # missing.add row["Location"] if locations[row["Location"]].blank?
    end
end

# puts ""
# puts "Missing:"
# pp missing.inject({}){|a, v| a[v] = 1; a}
# puts ""
# puts "All:"
# puts values.inspect
# puts ""

# found = Set.new
# values.each do |name|
#     members = Member.search(name)
#     found.add "#{name} (#{members.count})" if members.present?
# end
# pp found