class AdminHolidaysController < ApplicationController
  before_action :is_admin_in

  def is_admin_in
    manager_action
  end

  def index
    @holidays_pending = Holiday.where(status: "Pending")
    @holidays_confirmed = Holiday.where(status: "Confirmed") if current_user.manager?
    @holidays_canceled = Holiday.where(status: "Canceled")
  end

  def show
    @holiday = Holiday.find(params[:id])
  end

  def edit
    @holiday = Holiday.find(params[:id])
  end

  def update
    @holiday = Holiday.find(params[:id])
    if @holiday.update(holiday_params)
      if @holiday.user.emails_receiver == true
        UserMailer.holiday_notification_status(@holiday).deliver_now
      end
      flash[:notice] = "The holiday status was changed with sucess!"
      redirect_to admin_holiday_path(@holiday)
    else
      render 'edit'
    end
  end

  def destroy
    @holiday = Holiday.find(params[:id])
    @holiday.destroy
    flash[:notice] = "The holiday was deleted with sucess!"
    redirect_to admin_holidays_path
  end

  private
  def holiday_params
    params.require(:holiday).permit(:status)
  end

end
