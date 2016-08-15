class GraduatingClass < ActiveRecord::Base
  belongs_to :user
  has_many :students, class_name: 'Member'

  validates_uniqueness_of :year

  def name
    "Class of #{year}"
  end
end
