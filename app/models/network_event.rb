class NetworkEvent < ActiveRecord::Base
  validates :name, presence: true
  validates :program_id, presence: true
  validates :scheduled_at, presence: true
  validates :location_id, presence: true
  
  belongs_to :location
  belongs_to :user
  belongs_to :program
  belongs_to :organization
  
  has_many :site_assignments
  has_many :site_contacts, through: :site_assignments, source: :member
  
  has_many :school_assignments
  has_many :school_contacts, through: :school_assignments, source: :member
  
  has_many :volunteer_assignments
  has_many :volunteers, through: :volunteer_assignments, source: :member
  
  has_many :graduating_class_assignments
  has_many :graduating_classes, through: :graduating_class_assignments 
  
  def self.in_date_range(start_date, end_date)
    start_date = Date.strptime(start_date, '%A %B %d %Y')
    end_date = Date.strptime(end_date, '%A %B %d %Y')
    where(scheduled_at: start_date.beginning_of_day..end_date.end_of_day)
  end
  
  def self.default_date_range
    start_date= Date.today
    end_date = Date.today + 6.days 
    where(scheduled_at: start_date.beginning_of_day..end_date.end_of_day)
  end
  
  def name_with_date
    name + ' (' + scheduled_at.to_formatted_s(:long) + ')'
  end
end
