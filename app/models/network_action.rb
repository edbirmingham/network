class NetworkAction < ActiveRecord::Base
  belongs_to :network_event
  belongs_to :actor, class_name: 'Member'
  belongs_to :user
  
  has_many :matches, dependent: :delete_all
  has_many :members, through: :matches
  
  def self.types
    %w{ Offering Request Declaration BOTN }
  end
end
