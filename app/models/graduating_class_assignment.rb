class GraduatingClassAssignment < ApplicationRecord
  belongs_to :network_event
  belongs_to :graduating_class
  belongs_to :user
end
