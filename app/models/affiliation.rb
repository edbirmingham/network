class Affiliation < ApplicationRecord
  belongs_to :member
  belongs_to :organization
end
