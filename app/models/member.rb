class Member < ApplicationRecord
  default_scope { order(:last_name, :first_name) }

  include PgSearch

  pg_search_scope :search_by_full_name,
                  :against => [:first_name, :last_name],
                  :using => { :tsearch => {:prefix => true} }

  validates :first_name, presence: true
  validates :last_name, presence: true

  belongs_to :user
  belongs_to :graduating_class, class_name: 'GraduatingClass', foreign_key: :graduating_class_id
  belongs_to :school
  belongs_to :identity

  has_many :affiliations, dependent: :delete_all
  has_many :organizations, through: :affiliations

  has_many :talent_assignments, dependent: :delete_all
  has_many :talents, through: :talent_assignments

  has_many :extracurricular_activity_assignments, dependent: :delete_all
  has_many :extracurricular_activities, through: :extracurricular_activity_assignments

  has_many :residences, dependent: :delete_all
  has_many :neighborhoods, through: :residences

  has_many :participations, dependent: :delete_all
  has_many :events, through: :participations, source: :network_event

  has_many :cohortians, dependent: :delete_all
  has_many :cohorts, through: :cohortians

  has_many :matches, dependent: :delete_all
  has_many :matched_actions, through: :matches, source: :network_action

  has_many :communications, dependent: :destroy
  has_many :network_actions, dependent: :destroy, foreign_key: :actor_id

  def self.ethnicities
    %w{
      Hispanic\ or\ Latino\ or\ Spanish\ Origin
      Not\ Hispanic\ or\ Latino\ or\ Spanish\ Origin
    }
  end
  
  def self.races
    %w{
      American\ Indian\ or\ Alaska\ Native
      Asian
      Black\ or\ African\ American
      Native\ Hawaiian\ or\ Other\ Pacific\ Islander
      White
    }
  end
  
  def self.sexes
    %w{ Female Male }
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

  def extracurricular_activities_list
    extracurricular_activities.map(&:name).compact.sort.join(', ')
  end

  def affiliation_list
    organizations.map(&:name).compact.sort.join(', ')
  end
end
