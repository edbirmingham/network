require 'csv'
require 'set'

def location_lookup(locations, location)
    locations[location] || 
        Location.where(name: location).first.try(:id) || 
        Location.create!(name: location).id
end

if Rails.env.production?
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
        "Wylam" => 9, 
        "Wilkerson" => 10, 
        "WJ Christian" => 14, 
        "Phillips" => 15, 
        "Oliver ES" => 16
    }
else
    cohorts = {
       "Educate Local" => 4, 
       "GUB" => 1, 
       "AOE" => 4, 
       "AOHS" => 2, 
       "AOAC" => 4, 
       "AOUE" => 3, 
       "AOHT" => 4, 
       "AOBF" => 4,
       "SCM"=>4, 
       "AOIT"=>4, 
       "HS"=>4
    }
    
    graduating_classes = {
        "2022" => 7, 
        "2021" => 6, 
        "2020" => 5, 
        "2019" => 4, 
        "2018" => 3, 
        "2017" => 2,
        "7"=>7, 
        "8"=>7, 
        "10"=>4, 
        "11"=>3, 
        "12"=>2, 
        "9"=>5, 
        "--"=>nil, 
        "K-5"=>7, 
        "12-Sep"=>nil, 
        "8-Jun"=>nil, 
        nil=>nil, 
        "3"=>7, 
        "5"=>7, 
        "2"=>7, 
        "1"=>7, 
        "4"=>7
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
        "Wylam"=>2, 
        "Wilkerson"=>2, 
        "WJ Christian"=>2, 
        "Phillips"=>2, 
        "Oliver ES"=>2
    }
end

values = Set.new
missing = Set.new

index = 1
CSV.foreach("tmp/calendar.csv", headers: true) do |row|
    if row["Event Name"].present?
        index += 1
        scheduled_at = DateTime.strptime("#{row["Date"]}", "%m/%d/%y") rescue nil
        scheduled_at = DateTime.strptime("#{row["Date"]} #{row["Start time"]}", "%m/%d/%y %H:%M %p") rescue scheduled_at
        scheduled_at ||= Date.today + 2.months
        NetworkEvent.create!(
            name: row["Event Name"],
            school_ids: row["School"].try(:split, ', ').try(:map){|s| schools[s]},
            cohort_ids: row["Cohort"].try(:split, ', ').try(:map){|c| cohorts[c]},
            graduating_class_ids: [graduating_classes[row["Grade"]]].compact,
            program_id: programs[row["Program"]],
            location_id: location_lookup(locations, row["Location"]),
            scheduled_at: scheduled_at,
            duration: 60
            # , mongo_id: "csv.calendar.#{index}"
        )
        # row["School"].try(:split, ', ').try(:each) do |school|
        #     values.add school
        #     missing.add school if schools[school].blank?
        # end
        # puts row["School"] if schools[row["School"]].blank?
        # values.add row["Graduating Class"].split('-').last
        # puts row["Graduating Class"].split('-').last if graduating_classes[row["Graduating Class"].split('-').last].blank?
        # values.add row["Grade"]
        # missing.add row["Grade"] if graduating_classes[row["Grade"]].blank?
        # row["Cohort"].try(:split, ', ').try(:each) do |cohort|
        #     values.add cohort
        #     missing.add cohort if cohorts[cohort].blank?
        # end
        # puts row["Cohort"] if cohorts[row["Cohort"]].blank?
        # values.add row["Program"]
        # missing.add row["Program"] if programs[row["Program"]].blank?
        # values.add row["Location"]
        # missing.add row["Location"] if programs[row["Location"]].blank?
        # puts row["First Name"]
        # puts row["Last Name"]
        # puts "csv.#{file_name}.#{index}"
    end
end

puts missing.inject({}){|a, v| a[v] = 0; a}.inspect
puts values.inspect

