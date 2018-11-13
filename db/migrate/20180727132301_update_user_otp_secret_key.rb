class UpdateUserOtpSecretKey < ActiveRecord::Migration[5.2]
  def change
    User.where(encrypted_otp_secret_key: nil).each do |user|
      user.otp_secret_key = user.generate_totp_secret
      user.save
    end
  end
end
