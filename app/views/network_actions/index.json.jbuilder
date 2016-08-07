json.array!(@network_actions) do |network_action|
  json.extract! network_action, :id, :actor_id, :network_event_id, :action_type, :description, :user_id
  json.url network_action_url(network_action, format: :json)
end
