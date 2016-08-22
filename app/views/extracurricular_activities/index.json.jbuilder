json.array!(@extracurricular_activities) do |extracurricular_activity|
  json.extract! extracurricular_activity, :id, :name, :user_id
  json.url extracurricular_activity_url(extracurricular_activity, format: :json)
end
