class ExtracurricularActivity < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true
  
  has_many :extracurricular_activity_assignments
  has_many :members, through: :extracurricular_activity_assignments
end
