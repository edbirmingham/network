class NetworkEventTask < ApplicationRecord
  include PgSearch

  pg_search_scope :search_by_task_name,
                  :against => [:name],
                  :using => { :tsearch => {:prefix => true} }
  belongs_to :user
  belongs_to :owner, :class_name => "User"
  belongs_to :network_event
  belongs_to :common_task

  validates_presence_of :name

  def self.in_date_range(start_date, end_date)
    start_date = Date.strptime(start_date, '%A %B %d %Y')
    end_date = Date.strptime(end_date, '%A %B %d %Y')
    where(due_date: [start_date.beginning_of_day..end_date.end_of_day, nil])
  end

  def formatted_due_date
    if due_date.present?
      due_date.in_time_zone("Central Time (US & Canada)").strftime(' %a, %B %e %Y')
    else
      date_modifier
    end
  end

  def formatted_completed_at
    if completed_at.present?
      completed_at.in_time_zone("Central Time (US & Canada)").strftime(' %a, %B %e %Y')
    else
      nil
    end
  end

  def completed?
    return completed_at.present?
  end

  def as_json(options)
    result = super
    if completed_at?
      result["completed_at"] = completed_at.in_time_zone("Central Time (US & Canada)").strftime(' %a, %B %e %Y')
    end
    result
  end
end
