require 'test_helper'

class TalentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'should not save talent without name' do
    talent = Talent.new
    assert_not talent.save
  end
end
