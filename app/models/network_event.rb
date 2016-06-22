class NetworkEvent < ActiveRecord::Base
  validates :name, presence: true
  validates :event_type, presence: true
  validates :scheduled_at, presence: true
  validates :location_id, presence: true
  
  belongs_to :location
  
  def self.event_types
    [
      'College 101',
      'Raise Up Initiatives',
      'Educator Roundtable',
      'Connector Table Meeting',
      'Core Team Meeting'
    ]
  end
end
