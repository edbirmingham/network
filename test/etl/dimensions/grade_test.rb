require 'test_helper'

class ETLDimensionsGradeTest < ActiveSupport::TestCase
    def setup
        Etl::Dimensions::Grade.run
    end

    test 'Grade dimension ETL is idempotent' do
        assert_no_difference('GradeDimension.count') do
            Etl::Dimensions::Grade.run
        end
    end

    test 'Grade dimension ETL includes all grades' do
        all_grades = GraduatingClass.grade_names + ['Alum', 'Unspecified']
        assert_equal all_grades.sort, GradeDimension.all.map(&:name).sort
    end
end