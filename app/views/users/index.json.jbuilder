json.array!(@users) do |user|
  json.extract! user, :email
end
