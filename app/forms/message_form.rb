class MessageForm < Reform::Form
  property :subject
  property :body
  property :network_event
  property :sender

  validates :subject, :body, presence: true

  def recipient_ids=(val)
    # Assign multiple members by group
    group_mapping.slice(*val).each do |group, relation|
      self.model.member_recipients << relation
      val.delete group
    end

    # Assign specific members
    member_ids = val.select{|id| id.to_i.positive? }
    if member_ids.any?
      self.model.member_recipients << Member.find(member_ids)
    end

    # Assign adhoc people by email address
    adhoc_emails = val - member_ids
    adhoc_emails.each do |email|
      next if email.blank?
      self.model.adhoc_recipients << AdhocRecipient.where(email: email.downcase).first_or_initialize
    end
  end

  def recipient_ids
    self.model.message_recipient_ids + self.model.adhoc_recipients.pluck(:email)
  end

  private

  def group_mapping
    {
      NetworkEventContactsQuery::ALL_VOLUNTEERS.to_s => network_event.volunteers,
      NetworkEventContactsQuery::ALL_SITE_CONTACTS.to_s => network_event.site_contacts,
      NetworkEventContactsQuery::ALL_SCHOOL_CONTACTS.to_s => network_event.school_contacts
    }
  end

end
