class Member < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
  
  belongs_to :user
  has_many :affiliations
  has_many :organizations, through: :affiliations
  
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
end
