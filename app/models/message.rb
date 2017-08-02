class Message < ApplicationRecord
  enum status: [:created, :delivered, :error]
  belongs_to :sender, class_name: "User"
  belongs_to :network_event
  has_many :message_recipients
  has_many :member_recipients, through: :message_recipients, source: "recipient", source_type: "Member"
  has_many :adhoc_recipients, through: :message_recipients, source: "recipient", source_type: "AdhocRecipient"
end
