class Neighborhood < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :user
  
  has_many :residences
  has_many :members, through: :residences
end
