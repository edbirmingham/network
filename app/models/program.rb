class Program < ActiveRecord::Base
  	validates :name, presence: true
    validates_uniqueness_of :name
    has_many :network_events 
    belongs_to :user
end
