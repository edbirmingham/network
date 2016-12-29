class GraduatingClass < ActiveRecord::Base
  belongs_to :user
  has_many :students, class_name: 'Member'
  
  has_many :graduating_class_assignments, dependent: :delete_all
  has_many :network_events, through: :graduating_class_assignments

  validates_uniqueness_of :year

  def name
    "Class of #{year}"
  end
end
