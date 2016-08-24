class Cohort < ActiveRecord::Base
	validates :name, presence: true
  validates_uniqueness_of :name
  belongs_to :user
  has_many :cohortians
  has_many :cohorts, through: :cohortians
end
