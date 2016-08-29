class Organization < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name

  belongs_to :created_by, class_name: "User", foreign_key: :created_by_id
  has_many :affiliations
  has_many :members, through: :affiliations
  has_many :network_events
end
