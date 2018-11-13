class User < ApplicationRecord
  before_validation :set_otp_secret_key
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :two_factor_authenticatable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, 
         omniauth_providers: %i[surveymonkey]
  has_one_time_password(encrypted: true)

  has_many :created_organizations, class_name: "Organization", foreign_key: :created_by_id
  has_many :common_tasks
  has_many :tasks
  has_many :projects
  
  validates :otp_secret_key, presence: true
  
  def self.editable_options
    options = User.all.map {|u| { value: u.id, text: u.email } }
    options = [[nil, '']] + options
    options.to_json
  end
  
  def need_two_factor_authentication?(request)
    two_factor_auth?
  end
  
  def surveymonkey?
    surveymonkey_token.present? && surveymonkey_uid.present?
  end
  
  private
  
  def set_otp_secret_key
    if otp_secret_key.blank?
      self.otp_secret_key = generate_totp_secret
    end
  end
end
