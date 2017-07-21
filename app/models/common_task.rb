class CommonTask < ApplicationRecord
  belongs_to :user
  belongs_to :owner, :class_name => "User"
  
  def self.date_modifiers 
    [
      "Day before event",
      "1 week after event",
      "Monday before event",
      "2 Mondays before event",
      "Friday before event",
      "2 Fridays before event",
      "1 week before event",
      "2 weeks before event",
      "3 weeks before event",
      "1 month before event",
      "2 months before event",
      "3 months before event",
      "4 months before event"
    ]
  end
end
