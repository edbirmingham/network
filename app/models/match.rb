class Match < ApplicationRecord
  belongs_to :member
  belongs_to :network_action
  belongs_to :user
end
