class CohortAssignment < ActiveRecord::Base
  belongs_to :network_event
  belongs_to :cohort
  belongs_to :user
end
