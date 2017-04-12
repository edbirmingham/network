class NetworkEventTask < ApplicationRecord
  belongs_to :user
  belongs_to :owner, :class_name => "User"
  belongs_to :network_event
  belongs_to :common_task
  
  validates_presence_of :name
end