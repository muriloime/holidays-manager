load 'DateValidator.rb'

class Holiday < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 300 }
  validates :start_date, date: {on_or_after: :date_today}
  validates :end_date, date: {on_or_after: :start_date}

  def date_today
    Date.today
  end

end