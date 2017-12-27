class GraduatingClass < ApplicationRecord
  belongs_to :user
  has_many :students, class_name: 'Member'

  has_many :graduating_class_assignments, dependent: :delete_all
  has_many :network_events, through: :graduating_class_assignments

  validates_uniqueness_of :year

  def self.grade_names
    [
      "12th",
      "11th",
      "10th",
      "9th",
      "8th",
      "7th",
      "6th",
      "5th",
      "4th",
      "3rd",
      "2nd",
      "1st",
      "Kindergarten",
      "Pre-K4",
      "Pre-K3",
      "Pre-K2",
      "Pre-K1",
      "Pre-K0"
    ]
  end

  def name
    "Class of #{year}"
  end

  def grade(date=Date.today)
    diff = year - graduating_year(date)
    if diff >= 0
      GraduatingClass.grade_names[diff]
    else
      "Alum #{diff.abs}"
    end
  end

  private

  def graduating_year(date=Date.today)
      year = date.year
      if date.month >= 7
          year += 1
      end
      year
  end
end
