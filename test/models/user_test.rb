require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(
      email: 'user@example.com',
      password: 'password',
      surveymonkey_uid: 'test_uid',
      surveymonkey_token: 'test_token'
    )
  end
  
  test "should be saveable" do
    assert @user.save, "User failed to save."
  end
  
  test "should generate an OTP secret key for two factor authentication" do
    @user.save
    assert @user.otp_secret_key.present?, "OTP secret key not generated."
  end
  
  test "should respond to surveymonkey_uid" do
    assert_equal "test_uid", @user.surveymonkey_uid
  end
  
  test "should respond to surveymonkey_token" do
    assert_equal "test_token", @user.surveymonkey_token
  end

  test "should respond with SurveyMonkey enabled" do
    assert @user.surveymonkey?
  end
  
  test "should respond with SurveyMonkey disable when token is missing" do
    @user.surveymonkey_token = nil
    refute @user.surveymonkey?
  end
  
  test "should respond with SurveyMonkey disabled when uid is missing" do
    @user.surveymonkey_uid = nil
    refute @user.surveymonkey?
  end
end
