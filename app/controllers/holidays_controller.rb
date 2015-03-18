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
  end

  def create
    @holiday = current_user.holidays.build(holiday_params)

    if @holiday.save
      redirect_to @holiday
    else
      render 'new'
    end
  end

  def update
  end

  def destroy
  end

  private
  def holiday_params
    params.require(:holiday).permit(:content, :start_date, :end_date)
  end


end
