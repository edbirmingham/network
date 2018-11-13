class Communication < ApplicationRecord
  belongs_to :member
  belongs_to :user
  
  def self.kinds 
    %w{
      Call
      Email 
      Fundraising\ Request 
      Text
      Thank\ You\ Note
    }
  end
end
