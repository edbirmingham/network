json.array!(@graduating_classes) do |graduating_class|
  json.extract! graduating_class, :id, :year
  json.url graduating_class_url(graduating_class, format: :json)
end
