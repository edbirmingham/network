class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :created_organizations, class_name: "Organization", foreign_key: :created_by_id
  has_many :common_tasks
  has_many :network_event_tasks
end
