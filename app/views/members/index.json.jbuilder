json.array!(@members) do |member|
  json.extract! member, :id, :first_name, :last_name, :phone, :email, :identity, :affiliation, :address, :city, :state, :zip_code, :shirt_size, :shirt_received, :talent, :place_of_worship, :recruitment, :community_networks, :extra_groups, :other_networks, :user_id
  json.url member_url(member, format: :json)
end
