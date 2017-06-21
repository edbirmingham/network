class NetworkEventTask < ApplicationRecord
  belongs_to :user
  belongs_to :owner, :class_name => "User"
  belongs_to :network_event
  belongs_to :common_task
  
  validates_presence_of :name
  
  def self.in_date_range(start_date, end_date)
    start_date = Date.strptime(start_date, '%A %B %d %Y')
    end_date = Date.strptime(end_date, '%A %B %d %Y')
    where(due_date: [start_date.beginning_of_day..end_date.end_of_day, nil])
  end
  
end