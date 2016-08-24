class ExtracurricularActivityAssignment < ActiveRecord::Base
  belongs_to :member
  belongs_to :extracurricular_activity
  belongs_to :user
end
