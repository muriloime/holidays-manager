module UsersHelper

  def holidays_count(user)
    holidays_sum = 0;
    holidays_confirmed = Holiday.where(status:"Confirmed", user_id: user.id)
    holidays_confirmed.each do |holiday|
      holidays_sum += (holiday.end_date - holiday.start_date).to_s.chomp('/1').to_i + 1
    end
    return holidays_sum
  end

end
