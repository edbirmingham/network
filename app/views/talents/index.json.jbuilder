json.array!(@talents) do |talent|
  json.extract! talent, :id, :name
  json.url talent_url(talent, format: :json)
end
