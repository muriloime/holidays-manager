class UsersController < ApplicationController

  def index
    manager_action
    @users = User.all
  end

  def show
    @holidays = Holiday.where(status: "Confirmed")
  end

end
