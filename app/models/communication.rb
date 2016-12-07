class Communication < ActiveRecord::Base
  belongs_to :member
  belongs_to :user
  
  def self.kinds 
    %w{
      Email 
      Thank\ You\ Note
      Fundraising\ Request 
    }
  end
end
