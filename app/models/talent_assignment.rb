class TalentAssignment < ApplicationRecord
  belongs_to :talent
  belongs_to :member
  belongs_to :user
end
