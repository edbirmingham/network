class CommonTask < ApplicationRecord
  belongs_to :user
  belongs_to :owner, :class_name => "User"
  
  def self.date_modifiers 
    [
      "Day before",
      "Day of",
      "1 week after",
      "Monday before",
      "2 Mondays before",
      "Friday before",
      "2 Fridays before",
      "1 week before",
      "2 weeks before",
      "3 weeks before",
      "1 month before",
      "2 months before",
      "3 months before",
      "4 months before"
    ]
  end
end
