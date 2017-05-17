json.array!(@members) do |member|
  json.extract! member, :id, :text, :first_name, :last_name, :phone, :email, :identity_id, :school_id, :graduating_class_id
  json.url member_url(member, format: :json)
end
