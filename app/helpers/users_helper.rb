module UsersHelper

  def holidays_count(user)
    holidays_sum = 0;
    holidays_confirmed = Holiday.where(status:"Confirmed", user_id: user.id)
    holidays_confirmed.each do |holiday|
      holidays_sum += business_days_between(holiday.start_date,holiday.end_date)
    end
    return holidays_sum
  end

  def business_days_between(date1, date2)
    business_days = 0
    date = date2
    while date >= date1
      business_days = business_days + 1 unless date.saturday? or date.sunday?
      date = date - 1.day
    end
    business_days
  end

end
