class Cohort < ApplicationRecord
  default_scope { order(:name) }

  scope :active_cohorts, -> { where(active: true).order(:name) }

  validates :name, presence: true
  validates_uniqueness_of :name

  belongs_to :user
  has_many :cohortians, dependent: :delete_all
  has_many :members, through: :cohortians
end
