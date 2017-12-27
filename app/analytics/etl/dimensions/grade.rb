class Etl::Dimensions::Grade
    def self.run
        (GraduatingClass.grade_names + ['Alum', 'Unspecified']).each do |grade|
            attributes = { name: grade }
            unless GradeDimension.where(attributes).exists?
                GradeDimension.create(attributes)
            end
        end
    end
end