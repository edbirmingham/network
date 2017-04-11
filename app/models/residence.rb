class Residence < ApplicationRecord
  belongs_to :neighborhood
  belongs_to :member
  belongs_to :user
end
