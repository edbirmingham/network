class Cohort < ActiveRecord::Base
	validates :name, presence: true
  belongs_to :user
  has_many :cohortians
  has_many :cohorts, through: :cohortians
end
