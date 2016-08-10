class GraduatingClass < ActiveRecord::Base
  belongs_to :user
  
  validates_uniqueness_of :year
end
