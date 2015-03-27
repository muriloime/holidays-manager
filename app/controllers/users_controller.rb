class UsersController < ApplicationController
  before_action :is_current_user_in

  def is_current_user_in
    current_user?
  end

  def show
    @holidays = Holiday.all
    respond_to do |format|
      format.html # new.html.erb
      format.js
    end
  end

  def edit
    @user = current_user
  end

  def update_password
    @user = current_user
    if @user && @user.authenticate(params[:user][:password])
      if params[:user][:new_password] == params[:user][:repeat_new_password]
        if @user.update(user_params)
          flash[:notice] = "The new password was saved in the system"
          redirect_to @user
        else
          flash[:danger] = "The new password required 6 to 10 caracters"
          redirect_to edit_user_path(@user)
        end
      else
        flash[:danger] = "New Password and Repeat Password are not equal"
        redirect_to edit_user_path(@user)
      end
    else
      flash[:danger] = "Old Password is wrong"
      redirect_to edit_user_path(@user)
    end
  end

  private
  def user_params
    params[:user][:password] = params[:user][:new_password]
    params.require(:user).permit(:name, :login, :password, :manager)
  end

end
