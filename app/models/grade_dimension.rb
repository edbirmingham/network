class GradeDimension < ApplicationRecord
    def self.unspecified
        self.where(name: 'Unspecified').first
    end

    def self.sanitize(grade)
        grade = 'Alum' if grade =~ /Alum/
        grade
    end
end