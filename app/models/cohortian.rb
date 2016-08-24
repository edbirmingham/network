class Cohortian < ActiveRecord::Base
  belongs_to :member
  belongs_to :cohort
end
