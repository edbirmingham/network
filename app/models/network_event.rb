class NetworkEvent < ActiveRecord::Base
  validates :name, presence: true
  validates :program_id, presence: true
  validates :scheduled_at, presence: true
  validates :location_id, presence: true
  
  belongs_to :location
  belongs_to :user
  belongs_to :program
  
  
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
  
end
