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

  def to_json()
    {
    :textColor => 'black',
    :title => self.user.name,
    :start => self.start_date,
    :end => self.end_date.tomorrow,
    :url => ''  #if current_user.manager? then admin_holiday_path(holiday) else holiday_path(holiday) end
    }
  end

end