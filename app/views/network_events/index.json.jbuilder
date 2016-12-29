json.array!(@network_events) do |network_event|
  json.extract! network_event, :id, :name, :status, :program_id, :location_id, :scheduled_at, :user_id
  json.url network_event_url(network_event, format: :json)
end
