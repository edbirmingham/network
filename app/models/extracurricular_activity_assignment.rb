class ExtracurricularActivityAssignment < ApplicationRecord
  belongs_to :member
  belongs_to :extracurricular_activity
  belongs_to :user
end
