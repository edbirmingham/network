class Talent < ActiveRecord::Base
  belongs_to :user

  has_many :talent_assignments
  has_many :members, through: :talent_assignments

  validates :name, presence: true
  validates_uniqueness_of :name
end
