class NetworkAction < ActiveRecord::Base
  belongs_to :network_event
  belongs_to :actor, class_name: 'Member'
  belongs_to :user
  
  has_many :matches
  has_many :members, through: :matches
  
  def self.types
    %w{ Offering Request Declaration BOTN }
  end
end
