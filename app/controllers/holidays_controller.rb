class HolidaysController < ApplicationController
  include HolidaysHelper

  def index
    @holidays = Holiday.where(user_id: current_user.id)
  end

  def show
    @holiday = Holiday.find(params[:id])
  end

  def new
    @my_holidays = Holiday.where(user_id: current_user.id)
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
    @my_holidays = Holiday.where(user_id: current_user.id)
    @holiday = current_user.holidays.build(holiday_params)
    @holiday.status = "Pending"
    @holiday.status = "Confirmed" if current_user.manager?

    @holiday_exist = Holiday.exist_already(@holiday, current_user, -1)
    @holiday_exist.uniq!
    if  @holiday_exist.count > 0
      flash_conflict
      render 'new'
    else
      if @holiday.save
        @admin = User.where(login: "ciro.chang@studiare.com.br").first
        UserMailer.holiday_notification(@admin,@holiday).deliver_now
        flash[:notice] = "Holiday was created with sucess!"
        redirect_to holiday_path(@holiday)
      else
        render 'new'
      end
    end
  end

  def update
    @holiday = Holiday.find(params[:id])
    @new_holiday = Holiday.new(holiday_params)
    @holiday_exist = Holiday.exist_already(@new_holiday, current_user, @holiday.id)
    @holiday_exist.uniq!
    if  @holiday_exist.count > 0
      flash_conflict
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
    if @holiday.status != "Pending" && current_user.manager == false
      # Create an error message.
      flash[:danger] = "You just can delete when the status is Pending"
      redirect_to holidays_path
    elsif @holiday.user != current_user
      redirect_to root_url
    elsif
    @holiday.destroy
    flash[:notice] = "Holiday was deleted with sucess!"
    redirect_to holidays_path
    end
  end

  private
  def holiday_params
    params.require(:holiday).permit(:content, :start_date, :end_date, :status)
  end


end
