module HolidaysHelper

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
