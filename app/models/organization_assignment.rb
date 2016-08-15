class OrganizationAssignment < ActiveRecord::Base
  belongs_to :network_event
  belongs_to :organization
  belongs_to :user
end
