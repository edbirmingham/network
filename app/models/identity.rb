class Identity < ApplicationRecord
      validates :name, presence: true
      validates_uniqueness_of :name
      
      has_many :members
end
