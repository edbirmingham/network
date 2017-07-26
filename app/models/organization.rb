class Organization < ApplicationRecord
  validates :name, presence: true
  validates_uniqueness_of :name

  belongs_to :created_by, class_name: "User", foreign_key: :created_by_id
  
  has_many :affiliations, dependent: :delete_all
  has_many :members, through: :affiliations
  
  has_many :organization_assignments, dependent: :delete_all
  has_many :network_events, through: :organization_assignments
end
