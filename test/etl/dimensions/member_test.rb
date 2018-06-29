require 'test_helper'

class ETLDimensionsMemberTest < ActiveSupport::TestCase
  def setup
      @member = Member.new(
          first_name: 'First',
          last_name: 'Last',
          identity: identities(:student),
          graduating_class: graduating_classes(:class_of_2016),
          school: schools(:tuggle),
          city: 'Birmingham',
          state: 'AL',
          zip_code: '35205',
          high_school_gpa: 4.0,
          act_score: 24,
          sex: 'Female',
          race: 'Black or African American'
      )
      @member.save

      Etl::Dimensions::Member.run

      @member_dimension = MemberDimension.where(member_id: @member.id).first
  end

  test 'Date dimension ETL is idempotent' do
      assert_no_difference('MemberDimension.count') do
          Etl::Dimensions::Member.run
      end
  end

  test 'All members are extracted' do
      assert_equal Member.count, MemberDimension.count
  end

  test 'Identity is extracted' do
      assert_equal @member.identity.name, @member_dimension.identity
  end

  test 'Child in school system is extracted (column not added yet)' do
      assert_equal false, @member_dimension.child_in_school_system
  end

  test 'Graduating class is extracted' do
      assert_equal(
          graduating_classes(:class_of_2016).year,
          @member_dimension.graduating_class
      )
  end

  test 'School is extracted' do
      assert_equal schools(:tuggle).name, @member_dimension.school
  end

  test 'City is extracted' do
      assert_equal 'Birmingham', @member_dimension.city
  end

  test 'State is extracted' do
      assert_equal 'AL', @member_dimension.state
  end

  test 'Zip is extracted' do
      assert_equal '35205', @member_dimension.zip
  end
  
  test 'High School GPA is extracted' do
    assert_equal @member.high_school_gpa, @member_dimension.high_school_gpa
  end
  
  test 'ACT Score is extracted' do
    assert_equal @member.act_score, @member_dimension.act_score
  end
  
  test 'Sex is extracted' do
    assert_equal @member.sex, @member_dimension.sex
  end
  
  test 'Race is extracted' do
    assert_equal @member.race, @member_dimension.race
  end
end