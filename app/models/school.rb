class School < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  
  belongs_to :user
  
  has_many :students, class_name: 'Member'
  
  has_many :school_assignments, dependent: :delete_all
  has_many :network_events, through: :school_assignments
  
end
