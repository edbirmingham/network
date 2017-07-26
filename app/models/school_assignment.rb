class SchoolAssignment < ApplicationRecord
  belongs_to :network_event
  belongs_to :school
  belongs_to :user
end
