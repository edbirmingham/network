class Project < ApplicationRecord
  validates :name, presence: true
  before_save :apply_date_modifiers_to_tasks, if: :due_date_is_changed?
  
  has_many :tasks, dependent: :destroy
  belongs_to :owner, :class_name => "User"
  belongs_to :user
  
  accepts_nested_attributes_for :tasks
  
  def formatted_due_date
    if due_date.present?
      due_date.in_time_zone("Central Time (US & Canada)").strftime(' %a, %B %e %Y')
    end
  end
  
  def due_date_is_changed?
    return self.changes.include? 'due_date'
  end
  
  def apply_date_modifiers_to_tasks
    if self.due_date.present?
      self.tasks.each do |task|
        due_date = self.due_date.in_time_zone("Central Time (US & Canada)") 
        case task.date_modifier
        when 'Day before'
          task.due_date = due_date.end_of_day - 1.day
        when 'Day of'
          task.due_date = due_date.end_of_day
        when '1 week after'
          task.due_date = due_date.end_of_day + 1.week
        when 'Monday before'
          task.due_date = due_date.end_of_week(:tuesday) - 1.week
        when '2 Mondays before'
          task.due_date = due_date.end_of_week(:tuesday) - 2.weeks
        when 'Friday before'
          task.due_date = due_date.end_of_week(:saturday) - 1.week
        when '2 Fridays before'
          task.due_date = due_date.end_of_week(:saturday) - 2.weeks
        when '1 week before'
          task.due_date = due_date.end_of_day - 1.week
        when '2 weeks before'
          task.due_date = due_date.end_of_day - 2.weeks
        when '3 weeks before'
          task.due_date = due_date.end_of_day - 3.weeks
        when '1 month before'
          task.due_date = due_date.end_of_day - 1.months
        when '2 months before'
          task.due_date = due_date.end_of_day - 2.months
        when '3 months before'
          task.due_date = due_date.end_of_day - 3.months
        when '4 months before'
          task.due_date = due_date.end_of_day - 4.months
        else 
          task.due_date = nil
        end
        task.save
      end
    end
  end
  
end
