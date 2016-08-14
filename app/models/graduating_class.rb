class GraduatingClass < ActiveRecord::Base
  belongs_to :user
  
  validates_uniqueness_of :year
  
  def name
    "Class of #{year}"
  end
end
