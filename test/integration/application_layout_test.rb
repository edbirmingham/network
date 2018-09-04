require 'test_helper'

class ApplicationLayoutTest < ActionDispatch::IntegrationTest
  test "Surveys link should not show when logged out" do
    get new_user_session_path
    assert_select "a", { text: "Surveys", count: 0 }
  end
  
  test "Surveys link shows for registered SurveyMonkey users" do
    post user_session_path, params: {
      user: {
        email: users(:survey_user).email,
        password: 'password'
      }
    }
    follow_redirect!
    
    assert_select "a", { text: "Surveys", count: 1 }
  end
  
  test "Surveys link does not show for non-SurveyMonkey users" do
    post user_session_path, params: {
      user: {
        email: users(:non_survey_user).email,
        password: 'password'
      }
    }
    follow_redirect!
    
    assert_select "a", { text: "Surveys", count: 0 }
  end
end
