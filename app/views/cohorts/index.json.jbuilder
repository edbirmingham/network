json.array!(@cohorts) do |cohort|
  json.extract! cohort, :id, :name
  json.url cohort_url(cohort, format: :json)
end
