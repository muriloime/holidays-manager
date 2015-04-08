load 'DateValidator.rb'

class Holiday < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  validates :start_date, date: {on_or_after: :date_today} , if: :start_date
  validates :end_date, date: {on_or_after: :start_date} , if: :end_date

  def date_today
    Date.today
  end

  def self.exist_already(holiday, user, holiday_id)
    user.holidays.where(:start_date => holiday.start_date..holiday.end_date).where('id != ?', holiday_id).to_a +
         user.holidays.where(:end_date => holiday.start_date..holiday.end_date).where.not(id: holiday_id).to_a +
         user.holidays.where("start_date <= ? AND end_date >= ? AND id != ?", holiday.start_date, holiday.end_date, holiday_id).to_a
  end


  def get_days_to_start
    days_start = (start_date - Date.today).to_s.chomp('/1')
    if (days_start.to_i <= 0) then days_start = "-" end
    days_start
  end

  def get_days_to_end
    days_end = (end_date - Date.today + 1).to_s.chomp('/1')
    if (end_date < Date.today) then days_end = "-" end
    days_end
  end

  def get_days_total
    (end_date - start_date + 1).to_s.chomp('/1')
  end

  def get_days_total_business
    date1 = start_date
    date2 = end_date
    business_days = 0
    while date2 >= date1
      business_days = business_days + 1 unless date2.saturday? or date2.sunday?
      date2 = date2 - 1.day
    end
    business_days
  end

  def current?
    current = false
    days_start = get_days_to_start
    days_end = get_days_to_end
    if(days_start.equal?("-")) then days_start = "0" end
    if(days_end.equal?("-")) then days_end = "0" end
    if(days_start.to_i <= 0 && days_end.to_i > 0) then current = true end
    current
  end

  def as_json(options = {})
    collor = '#999999'
    if self.status == "Confirmed" then collor = '#00CCFF' end
    if self.status == "Canceled" then collor = '#FF3030' end
    {
    :textColor => 'black',
    :color => collor,
    :title => "#{self.user.name} - #{self.content}",
    :start => self.start_date,
    :end => self.end_date.tomorrow,
    :url => Rails.application.routes.url_helpers.holiday_path(self)
    }
  end

end