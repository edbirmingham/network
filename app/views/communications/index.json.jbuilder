json.array!(@communications) do |communication|
  json.extract! communication, :id, :kind, :notes, :member_id, :user_id
  json.url communication_url(communication, format: :json)
end
