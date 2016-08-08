json.array!(@members) do |member|
  json.extract! member, :id, :text
  json.url member_url(member, format: :json)
end
