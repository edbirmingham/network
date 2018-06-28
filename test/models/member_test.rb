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
  
  test 'should save member with ACT score' do
    member = Member.new(first_name: 'First', last_name: 'Last', act_score: 25)
    assert member.save 
  end
  
  test 'should save member with relative phone number' do
    member = Member.new(first_name: 'First', last_name: 'Last', relative_phone: '2055869999')
    assert member.save 
  end
  
  test 'should save member with relative email address' do
    member = Member.new(first_name: 'First', last_name: 'Last', relative_email: 'relative@example.com')
    assert member.save 
  end
  
  test 'should save member with facebook name' do
    member = Member.new(first_name: 'First', last_name: 'Last', facebook_name: 'facebookname')
    assert member.save 
  end
  
  test 'should save member with twitter handle' do
    member = Member.new(first_name: 'First', last_name: 'Last', twitter_handle: 'twitterhandle')
    assert member.save 
  end
  
  test 'should save member with instagram handle' do
    member = Member.new(first_name: 'First', last_name: 'Last', instagram_handle: 'instagramhandle')
    assert member.save 
  end
    
end
