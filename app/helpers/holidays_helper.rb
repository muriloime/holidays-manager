module HolidaysHelper

  def exist_already(holiday, holiday_id)
    @holiday_exist = Holiday.where(:start_date => holiday.start_date..holiday.end_date, user_id: holiday.user.id, id: !holiday_id)
    @holiday_exist += Holiday.where(:end_date => holiday.start_date..holiday.end_date, user_id: holiday.user.id, id: !holiday_id)
    @holiday_exist += Holiday.where("start_date <= ? AND end_date >= ? AND user_id = ? AND id != ?", holiday.start_date, holiday.end_date, holiday.user.id, holiday_id)

    @holiday_exist = Holiday.where(:start_date => @holiday.start_date..@holiday.end_date, user_id: @holiday.user_id, id: -1)
    @holiday_exist += Holiday.where(:end_date => @holiday.start_date..@holiday.end_date, user_id: @holiday.user_id, id: -1)
    @holiday_exist += Holiday.where("start_date <= ? AND end_date >= ? AND user_id = ? AND id != ?", @holiday.start_date, @holiday.end_date, @holiday.user_id, -1)
  end

  def flash_conflict
    flash.now[:info] = "You have already Holliday(s) between these dates:</br>"
    @holiday_exist.each do |holiday|
      flash.now[:info] += "</br> Start Date: #{holiday.start_date.strftime("%d/%m/%y")}"
      flash.now[:info] += "</br> End Date: #{holiday.end_date.strftime("%d/%m/%y")}"
      flash.now[:info] += "</br> Status: #{holiday.status}"
      flash.now[:info] += "</br> Content: #{holiday.content} </br>"
    end
    flash.now[:info] += "</br> Please delete these Holiday(s) first. "
  end

end
