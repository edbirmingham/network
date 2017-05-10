class NetworkEventTask < ApplicationRecord
  belongs_to :user
  belongs_to :network_event
  belongs_to :common_task
  belongs_to :owner, :class_name => "User"
  
  validates_presence_of :name
  validates_presence_of :common_task_id
end