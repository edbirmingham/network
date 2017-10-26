Task.all.each do |task|
  case task.date_modifier
  when 'Day before event'
    task.date_modifier = 'Day before' 
  when 'Day of event'
    task.date_modifier = 'Day of' 
  when '1 week after event'
    task.date_modifier = '1 week after' 
  when 'Monday before event'
    task.date_modifier = 'Monday before' 
  when '2 Mondays before event'
    task.date_modifier = '2 Mondays before' 
  when 'Friday before event'
    task.date_modifier = 'Friday before' 
  when '2 Fridays before event'
    task.date_modifier = '2 Fridays before' 
  when '1 week before event'
    task.date_modifier = '1 week before' 
  when '2 weeks before event'
    task.date_modifier = '2 weeks before' 
  when '3 weeks before event'
    task.date_modifier = '3 weeks before' 
  when '1 month before event'
    task.date_modifier = '1 month before' 
  when '2 months before event'
    task.date_modifier = '2 months before' 
  when '3 months before event'
    task.date_modifier = '3 months before' 
  when '4 months before event'
    task.date_modifier = '4 months before' 
  else 
    task.date_modifier = nil
  end
  task.save
end

CommonTask.all.each do |task|
  case task.date_modifier
  when 'Day before event'
    task.date_modifier = 'Day before' 
  when 'Day of event'
    task.date_modifier = 'Day of' 
  when '1 week after event'
    task.date_modifier = '1 week after' 
  when 'Monday before event'
    task.date_modifier = 'Monday before' 
  when '2 Mondays before event'
    task.date_modifier = '2 Mondays before' 
  when 'Friday before event'
    task.date_modifier = 'Friday before' 
  when '2 Fridays before event'
    task.date_modifier = '2 Fridays before' 
  when '1 week before event'
    task.date_modifier = '1 week before' 
  when '2 weeks before event'
    task.date_modifier = '2 weeks before' 
  when '3 weeks before event'
    task.date_modifier = '3 weeks before' 
  when '1 month before event'
    task.date_modifier = '1 month before' 
  when '2 months before event'
    task.date_modifier = '2 months before' 
  when '3 months before event'
    task.date_modifier = '3 months before' 
  when '4 months before event'
    task.date_modifier = '4 months before' 
  else 
    task.date_modifier = nil
  end
  task.save
end