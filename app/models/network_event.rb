class NetworkEvent < ActiveRecord::Base
  validates :name, presence: true
  validates :program_id, presence: true
  validates :scheduled_at, presence: true
  validates :location_id, presence: true
  
  belongs_to :location
  belongs_to :user
  belongs_to :program
  
  
  def self.in_date_range(start_date, end_date)
    start_datetime = DateTime.strptime(start_date, '%m/%d/%Y %I:%M %p')
    end_datetime = DateTime.strptime(end_date, '%m/%d/%Y %I:%M %p')
    where(scheduled_at: start_datetime..end_datetime)
  end
  
  def self.default_date_range
    start_datetime = Date.today
    end_datetime = Date.today + 1.week + 1.day
    where(scheduled_at: start_datetime..end_datetime)
  end
  
end
