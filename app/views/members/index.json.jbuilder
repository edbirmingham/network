json.array!(@members) do |member|
  json.extract! member, :id, :text, :first_name, :last_name, :phone, :email
  json.url member_url(member, format: :json)
end
