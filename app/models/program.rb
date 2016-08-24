class Program < ActiveRecord::Base
  	validates :name, presence: true
    has_many :network_events 
    belongs_to :user
end
