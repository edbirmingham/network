class AdhocRecipient < ApplicationRecord
  validates :email, presence: true
end
