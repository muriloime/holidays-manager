class HolidaysController < ApplicationController

  def index
    @holidays = Holiday.where(user_id: current_user.id)
  end

  def show
    @holiday = Holiday.find(params[:id])
  end

  def new
    @holiday = Holiday.new
  end

  def edit
    @holiday = Holiday.find(params[:id])
    if @holiday.user != current_user
      redirect_to root_url
    end
    if @holiday.status != "Pending" && current_user.manager == false
      # Create an error message.
      flash[:danger] = "You just can edit when the status is Pending"
      redirect_to holidays_path
    end
  end

  def create
    @holiday = current_user.holidays.build(holiday_params)
    @holiday.status = "Pending"
    @holiday.status = "Confirmed" if current_user.manager?
    @holiday_exist = Holiday.where(:start_date => @holiday.start_date..@holiday.end_date, user_id: current_user.id)
    @holiday_exist += Holiday.where(:end_date => @holiday.start_date..@holiday.end_date, user_id: current_user.id)
    @holiday_exist += Holiday.where("start_date <= ? AND end_date >= ? AND user_id = ?", @holiday.start_date, @holiday.end_date, current_user.id)
    @holiday_exist.uniq!
    if  @holiday_exist.count > 0
      flash.now[:info] = "You have already Holliday(s) between these dates:</br>"
      @holiday_exist.each do |holiday|
        flash.now[:info] += "</br> Start Date: #{holiday.start_date.strftime("%d/%m/%y")}"
        flash.now[:info] += "</br> End Date: #{holiday.end_date.strftime("%d/%m/%y")}"
        flash.now[:info] += "</br> Status: #{holiday.status}"
        flash.now[:info] += "</br> Content: #{holiday.content} </br>"
      end
      flash.now[:info] += "</br> Please delete these Holiday(s) first. "
      render 'new'
    else
      if @holiday.save
        flash[:notice] = "Holiday was created with sucess!"
        redirect_to holiday_path(@holiday)
      else
        render 'new'
      end
    end
  end

  def update
    @holiday = Holiday.find(params[:id])
    @holiday_exist = Holiday.where(:start_date => @holiday.start_date..@holiday.end_date, user_id: current_user.id, id: !@holiday.id)
    @holiday_exist += Holiday.where(:end_date => @holiday.start_date..@holiday.end_date, user_id: current_user.id, id: !@holiday.id)
    @holiday_exist += Holiday.where("start_date <= ? AND end_date >= ? AND user_id = ? AND id != ?", @holiday.start_date, @holiday.end_date, current_user.id, @holiday.id)
    @holiday_exist.uniq!
    if  @holiday_exist.count > 0
      flash.now[:info] = "You have already Holliday(s) between these dates:</br>"
      @holiday_exist.each do |holiday|
        flash.now[:info] += "</br> Start Date: #{holiday.start_date.strftime("%d/%m/%y")}"
        flash.now[:info] += "</br> End Date: #{holiday.end_date.strftime("%d/%m/%y")}"
        flash.now[:info] += "</br> Status: #{holiday.status}"
        flash.now[:info] += "</br> Content: #{holiday.content} </br>"
      end
      flash.now[:info] += "</br> Please delete these Holiday(s) first. "
      render 'edit'
    else
      if @holiday.update(holiday_params)
        flash[:notice] = "Holiday was change with sucess!"
        redirect_to @holiday
      else
        render 'edit'
      end
    end
  end

  def destroy
    @holiday = Holiday.find(params[:id])
    if @holiday.user != current_user
      redirect_to root_url
    end
    @holiday.destroy
    flash[:notice] = "Holiday was deleted with sucess!"
    redirect_to holidays_path
  end

  private
  def holiday_params
    params.require(:holiday).permit(:content, :start_date, :end_date, :status)
  end


end
