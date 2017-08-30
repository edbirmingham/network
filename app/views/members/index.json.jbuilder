json.array!(@members) do |member|
  json.extract! member, :id, :first_name, :last_name, :phone, :email, :identity_id, :school_id, :graduating_class_id
  if params[:include] == 'cohorts' && member.cohorts.present?
    json.text member.text + " (#{member.cohorts.map(&:name).join(', ')})"
  elsif member.email.present?
    json.text member.text + " (#{member.email})"
  else
    json.text member.text
  end
  json.url member_url(member, format: :json)
end
