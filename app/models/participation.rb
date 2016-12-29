# Particiption links members and events to track participation levels
class Participation < ActiveRecord::Base
  belongs_to :user
  belongs_to :member
  belongs_to :network_event

  validates :level, presence: true

  def attendee?
    level == 'attendee'
  end

  def volunteer?
    level == 'volunteer'
  end
end
