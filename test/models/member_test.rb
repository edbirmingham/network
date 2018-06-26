require 'test_helper'

class MemberTest < ActiveSupport::TestCase
  test "should not save member without first name" do
    member = Member.new(last_name: 'Last')
    assert_not member.save
  end
  
  test "should not save member without last name" do
    member = Member.new(first_name: 'First')
    assert_not member.save
  end
  
  test "should save member with first and last names" do
    member = Member.new(first_name: 'First', last_name: 'Last')
    assert member.save
  end

  test 'should save member with date of birth' do
    member = Member.new(first_name: 'First', last_name: 'Last', date_of_birth: 20.days.ago)
    assert member.save 
  end
  
  test 'should save member with high school gpa' do
    member = Member.new(first_name: 'First', last_name: 'Last', high_school_gpa: 4.0)
    assert member.save 
  end
    
end
