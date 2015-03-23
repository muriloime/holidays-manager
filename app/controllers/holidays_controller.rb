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
    if @holiday.save
      redirect_to holiday_path(@holiday)
    else
      render 'new'
    end
  end

  def update
    @holiday = Holiday.find(params[:id])
    if @holiday.update(holiday_params)
      redirect_to @holiday
    else
      render 'edit'
    end
  end

  def destroy
    @holiday = Holiday.find(params[:id])
    if @holiday.user != current_user
      redirect_to root_url
    end
    @holiday.destroy
    redirect_to holidays_path
  end

  private
  def holiday_params
    params.require(:holiday).permit(:content, :start_date, :end_date, :status)
  end


end
