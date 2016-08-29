class Neighborhood < ActiveRecord::Base
  validates :name, presence: true
  validates_uniqueness_of :name
  
  belongs_to :user
  
  has_many :residences
  has_many :members, through: :residences
end
