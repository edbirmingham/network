class SchoolContactAssignment < ActiveRecord::Base
  belongs_to :network_event
  belongs_to :member
  belongs_to :user
end
