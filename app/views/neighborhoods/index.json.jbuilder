json.array!(@neighborhoods) do |neighborhood|
  json.extract! neighborhood, :id, :name
  json.url neighborhood_url(neighborhood, format: :json)
end
