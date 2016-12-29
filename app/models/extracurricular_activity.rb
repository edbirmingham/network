class ExtracurricularActivity < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true
  validates_uniqueness_of :name
  
  has_many :extracurricular_activity_assignments, dependent: :delete_all
  has_many :members, through: :extracurricular_activity_assignments
end
