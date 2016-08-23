require 'test_helper'

class ParticipationTest < ActiveSupport::TestCase
  test 'should save participation with level' do
    participation = Participation.new(level: 'attendee')
    assert participation.save
  end

  test 'should not save participation without level' do
    participation = Participation.new
    assert_not participation.save
  end

  test 'should be attendee when level is set as attendee' do
    participation = participations(:attendee)
    assert participation.attendee?
    assert_not participation.volunteer?
  end

  test 'should be volunteer when level is set as volunteer' do
    participation = participations(:volunteer)
    assert participation.volunteer?
    assert_not participation.attendee?
  end
end
