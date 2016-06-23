class NetworkEvent < ActiveRecord::Base
  validates :name, presence: true
  validates :program_id, presence: true
  validates :scheduled_at, presence: true
  validates :location_id, presence: true
  
  belongs_to :location
  belongs_to :user
  belongs_to :program
  
end
