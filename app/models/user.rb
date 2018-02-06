class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :created_organizations, class_name: "Organization", foreign_key: :created_by_id
  has_many :common_tasks
  has_many :tasks
  has_many :projects
  
  def self.editable_options
    options = User.all.map {|u| { value: u.id, text: u.email } }
    options = [[nil, '']] + options
    options.to_json
  end
end
