class ExtracurricularActivity < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true
<<<<<<< 90d3d14262fb58a779b2a814f2822887183a013c
=======
  validates_uniqueness_of :name
>>>>>>> Add Extracurricular management
  
  has_many :extracurricular_activity_assignments
  has_many :members, through: :extracurricular_activity_assignments
end
