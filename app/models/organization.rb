class Organization < ActiveRecord::Base
  validates :name, presence: true
end
