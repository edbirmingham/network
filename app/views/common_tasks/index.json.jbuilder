json.array!(@common_tasks) do |common_task|
  json.extract! common_task, :id, :name, :user_id
  json.url common_task_url(common_task, format: :json)
end
