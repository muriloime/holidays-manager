class AdminHolidaysController < ApplicationController
  before_action :is_admin_in

  def is_admin_in
    if current_user.manager == false
      redirect_to root_url
    end
  end

  def index
    @holidays = Holiday.all
  end

  def show
    @holiday = Holiday.find(params[:id])
  end

  def edit
    @holiday = Holiday.find(params[:id])
  end

  def create
    @holiday = current_user.holidays.build(holiday_params)
    @holiday.status = "Pending"

    if @holiday.save
      redirect_to @holiday
    else
      render 'new'
    end
  end

  def destroy
    @holiday = Holiday.find(params[:id])
    @holiday.destroy

    redirect_to admin_holidays_path
  end

  private
  def holiday_params
    params.require(:holiday).permit(:content, :start_date, :end_date, :status)
  end


end
