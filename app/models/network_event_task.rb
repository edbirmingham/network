class NetworkEventTask < ActiveRecord::Base
  belongs_to :user
  belongs_to :network_event
  belongs_to :common_task
  
  validates_presence_of :name
  validates_presence_of :common_task_id
end