class NetworkAction < ApplicationRecord
  belongs_to :network_event
  belongs_to :actor, class_name: 'Member'
  belongs_to :owner, class_name: 'User'
  belongs_to :user
  
  has_many :matches, dependent: :delete_all
  has_many :members, through: :matches
  
  enum status: [:created, :matched, :unmatched, :in_progress, :complete]
  enum priority: [:needs_priority, :high_feasibility, :high_impact, :high_feasibility_and_high_impact]
  
  def self.types
    %w{ Offering Request Declaration BOTN }
  end
end
