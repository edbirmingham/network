class NetworkEvent < ActiveRecord::Base
  validates :name, presence: true
  validates :program_id, presence: true
  validates :scheduled_at, presence: true
  validates :location_id, presence: true
  

  belongs_to :location
  belongs_to :user
  belongs_to :program

  has_many :site_contact_assignments, dependent: :delete_all
  has_many :site_contacts, through: :site_contact_assignments, source: :member

  has_many :school_contact_assignments, dependent: :delete_all
  has_many :school_contacts, through: :school_contact_assignments, source: :member

  has_many :volunteer_assignments, dependent: :delete_all
  has_many :volunteers, through: :volunteer_assignments, source: :member

  has_many :graduating_class_assignments, dependent: :delete_all
  has_many :graduating_classes, through: :graduating_class_assignments

  has_many :organization_assignments, dependent: :delete_all
  has_many :organizations, through: :organization_assignments

  has_many :school_assignments, dependent: :delete_all
  has_many :schools, through: :school_assignments

  has_many :cohort_assignments, dependent: :delete_all
  has_many :cohorts, through: :cohort_assignments

  has_many :participations, dependent: :delete_all
  has_many :participants, through: :participations, source: :member


  def self.in_date_range(start_date, end_date)
    start_date = Date.strptime(start_date, '%A %B %d %Y')
    end_date = Date.strptime(end_date, '%A %B %d %Y')
    where(scheduled_at: start_date.beginning_of_day..end_date.end_of_day)
  end

  def self.default_date_range
    start_date= Date.today
    end_date = Date.today + 6.days
    where(scheduled_at: start_date.beginning_of_day..end_date.end_of_day)
  end

  def date
    scheduled_at.to_date
  end
  
  def invitees
    member_scope = Member.uniq

    if cohorts.any?
      member_scope = member_scope.joins(:cohorts).where(cohorts: { id: cohort_ids })
    end

    if schools.any?
      member_scope = member_scope.where(school_id: school_ids)
    end

    if graduating_classes.any?
      member_scope = member_scope.where(graduating_class_id: graduating_class_ids)
    end

    member_scope
  end
  
  def location_name
    location.try(:name)
  end
  
  def name_with_date
    name + ' (' + scheduled_at.to_formatted_s(:long) + ')'
  end

  def program_name
    program.try(:name)
  end
  
  def start_time
    scheduled_at.to_time
  end
  
  def stop_time
    (scheduled_at + duration.minutes).to_time
  end
  
end
