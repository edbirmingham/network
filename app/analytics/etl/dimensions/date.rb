class Etl::Dimensions::Date
    def self.run
        load_date_range
        load_null_date
    end

    private

    def self.beginning_of_first_school_week(date)
        first_day_of_school(date).beginning_of_week
    end

    def self.calendar_quarter(date)
        (date.month / 3.0).ceil
    end

    def self.calendar_year_quarter(date)
        "#{date.year} Q#{calendar_quarter(date)}"
    end

    def self.day_number_in_school_year(date)
        (date - first_day_of_school(date)).to_i + 1
    end

    def self.first_day_of_school(date)
        (school_year_number(date).to_s + '-07-01').to_date
    end

    def self.load_date_range
        date = NetworkEvent.minimum(:scheduled_at).to_date
        max_date = NetworkEvent.maximum(:scheduled_at).to_date
        while date <= max_date do
            attributes = {
                date: date.to_date,
                full_date_description: date.strftime('%B %-d, %Y'),
                day_of_week: date.strftime('%A'),
                day_number_in_calendar_month: date.day,
                day_number_in_calendar_year: date.yday,
                day_number_in_school_year: day_number_in_school_year(date),
                calendar_week_beginning_date: date.beginning_of_week,
                calendar_week_number_in_year: date.cweek,
                calendar_month_name: date.strftime('%B'),
                calendar_month_number_in_year: date.month,
                calendar_year_month: date.strftime('%Y-%m'),
                calendar_quarter: calendar_quarter(date),
                calendar_year_quarter: calendar_year_quarter(date),
                calendar_year_half: (date.month / 6.0).ceil,
                calendar_year: date.year,
                school_week_number_in_year: school_week_number_in_year(date),
                school_year: school_year(date),
                school_year_number: school_year_number(date),
                school_month_number_in_year: school_month_number_in_year(date),
                school_year_month: school_year_month(date),
                school_quarter: school_quarter(date),
                school_year_quarter: school_year_quarter(date),
                school_year_half: (school_month_number_in_year(date) / 6.0).ceil,
                weekday_indicator: weekday_indicator(date)
            }
            persist_date attributes

            date = date + 1.day
        end
    end

    def self.load_null_date
        null_date_description = 'No Date Provided'
        attributes = {
            date: nil,
            full_date_description: null_date_description,
            day_of_week: null_date_description,
            day_number_in_calendar_month: nil,
            day_number_in_calendar_year: nil,
            day_number_in_school_year: nil,
            calendar_week_beginning_date: nil,
            calendar_week_number_in_year: nil,
            calendar_month_name: null_date_description,
            calendar_month_number_in_year: nil,
            calendar_year_month: null_date_description,
            calendar_quarter: null_date_description,
            calendar_year_quarter: nil,
            calendar_year_half: nil,
            calendar_year: nil,
            school_week_number_in_year: nil,
            school_year: null_date_description,
            school_year_number: nil,
            school_month_number_in_year: nil,
            school_year_month: null_date_description,
            school_quarter: nil,
            school_year_quarter: null_date_description,
            school_year_half: nil,
            weekday_indicator: null_date_description
        }
        persist_date attributes

    end

    def self.persist_date(attributes)
        if DateDimension.where(date: attributes[:date]).exists?
            DateDimension.
                where(date: attributes[:date]).
                update_all(attributes)
        else
            DateDimension.create(attributes)
        end
    end

    def self.school_month_number_in_year(date)
        month_number = date.month
        if month_number < 7
            month_number += 6
        else
            month_number -= 6
        end

        month_number
    end

    def self.school_quarter(date)
        (school_month_number_in_year(date) / 3.0).ceil
    end

    def self.school_week_number_in_year(date)
        week_number = ((date - beginning_of_first_school_week(date)) / 7.0).ceil

        monday = 1
        if date.wday == monday
            week_number += 1
        end

        week_number
    end

    def self.school_year(date)
        year = school_year_number(date)
        "#{year}-#{year+1}"
    end

    def self.school_year_month(date)
        "#{school_year(date)} M#{school_month_number_in_year(date)}"
    end

    def self.school_year_number(date)
        year = date.year
        if date.month < 7
            year -= 1
        end
        year
    end

    def self.school_year_quarter(date)
        "#{school_year(date)} Q#{school_quarter(date)}"
    end

    def self.weekday_indicator(date)
        if [0, 6].include? date.wday
            'Weekend'
        else
            'Weekday'
        end
    end
end