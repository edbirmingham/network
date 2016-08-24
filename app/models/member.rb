class Member < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :user
  belongs_to :graduating_class, class_name: 'GraduatingClass', foreign_key: :graduating_class_id
  belongs_to :school
  has_many :affiliations
  has_many :organizations, through: :affiliations
  has_many :talent_assignments
  has_many :talents, through: :talent_assignments
  has_many :residences
  has_many :neighborhoods, through: :residences
  has_many :participations
  has_many :events, through: :participations, source: :network_event
  has_many :cohortians
  has_many :cohorts, through: :cohortians

  def self.search(query)
    if query.present?
      condition = 'first_name LIKE :search OR last_name LIKE :search'
      query.split(' ').inject(self) do |conditions, term|
        conditions.where([condition, search: "#{term}%"])
      end
    else
      all
    end
  end

  def self.shirt_sizes
    %w{ S M L XL 2XL 3XL }
  end

  def self.identities
    %w{
      Student
      Parent
      Educator
      Resident
      Community\ Partner
    }
  end

  def name
    [first_name, last_name].compact.join(' ')
  end

  def text
    name
  end

  def graduation_year
    if graduating_class
      graduating_class.year
    else
      ''
    end
  end

  def talent_list
    talents.map(&:name).compact.sort.join(', ')
  end
end
