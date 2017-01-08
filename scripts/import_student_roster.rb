require 'csv'
require 'set'

def cohort_lookup(cohort)
    Cohort.where(name: cohort).first || Cohort.create!(name: cohort)
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
       "AOBF" => 2 
    }
    
    graduating_classes = {
        "2022" => 7, 
        "2021" => 6, 
        "2020" => 5, 
        "2019" => 3, 
        "2018" => 2, 
        "2017" => 1
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
        "Woodlawn HS" => 2
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
       "AOBF" => 4 
    }
    
    graduating_classes = {
        "2022" => 7, 
        "2021" => 6, 
        "2020" => 5, 
        "2019" => 4, 
        "2018" => 3, 
        "2017" => 2
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
        "Woodlawn HS" => 2
    }
end

values = Set.new

file_names = %w{ students_7th students_8th students_9th students_10th students_11th students_12th }

file_names.each do |file_name|
    index = 1
    CSV.foreach("tmp/#{file_name}.csv", headers: true) do |row|
        if row["School"].present?
            index += 1
            # Member.create!(
            #     first_name: row["First Name"],
            #     last_name: row["Last Name"],
            #     school_id: schools[row["School"]],
            #     cohort_ids: [cohorts[row["Cohort"]]],
            #     graduating_class_id: graduating_classes[row["Graduating Class"].split('-').last],
            #     mongo_id: "csv.#{file_name}.#{index}"
            # )
            
            member = Member.where(mongo_id: "csv.#{file_name}.#{index}").first
            if member.present? && row["Class"].present?
                member.cohorts << cohort_lookup(row["Class"])
            end
            
            # values.add row["School"]
            # puts row["School"] if schools[row["School"]].blank?
            # values.add row["Graduating Class"].split('-').last
            # puts row["Graduating Class"].split('-').last if graduating_classes[row["Graduating Class"].split('-').last].blank?
            # values.add row["Cohort"]
            # puts row["Cohort"] if cohorts[row["Cohort"]].blank?
            # puts row["First Name"]
            # puts row["Last Name"]
            # puts "csv.#{file_name}.#{index}"
        end
    end
end