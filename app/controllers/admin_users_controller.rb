class AdminUsersController < ApplicationController
before_action :is_admin_in

  def is_admin_in
    manager_action
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user)
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    require 'securerandom'
    @user.password = SecureRandom.hex[0,10]
    if @user.save
      flash[:danger] = "The temporary password of #{@user.name} is: #{@user.password}"
      redirect_to admin_user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :login, :password, :manager)
  end


end