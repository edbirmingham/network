json.array!(@organizations) do |organization|
  json.extract! organization, :id, :name
  json.url organization_url(organization, format: :json)
end
