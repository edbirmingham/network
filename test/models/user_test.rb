require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = User.new(
      email: 'user@example.com',
      password: 'password'
    )
  end
  
  test "should be saveable" do
    assert @user.save, "User failed to save."
  end
  
  test "should generate an OTP secret key for two factor authentication" do
    @user.save
    assert @user.otp_secret_key.present?, "OTP secret key not generated."
  end
end
