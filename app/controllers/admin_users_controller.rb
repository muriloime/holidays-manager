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
    if @user.update_attributes(user_params)
      flash[:notice] = "The #{@user.name} was updated with sucess!"
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
      flash[:notice] = "The #{@user.name} was created with sucess!"
      UserMailer.welcome(@user).deliver_now
      flash[:key] = "The temporary password of #{@user.name} was sent to #{@user.login}"
      redirect_to admin_user_path(@user)
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find(params[:id])
    flash[:notice] = "The #{@user.name} was deleted with sucess!"
    @user.destroy
    redirect_to admin_users_path
  end

  def reset_password
    @user = User.find(params[:id])
    require 'securerandom'
    @user.password = SecureRandom.hex[0,10]
    if @user.save
      UserMailer.password_reset(@user).deliver_now
      flash[:key] = "The temporary password of #{@user.name} was sent to #{@user.login}"
      redirect_to admin_users_path
    else
      flash[:danger] = "It is not possible do this"
      redirect_to admin_users_path
    end

  end

  private
  def user_params
    params.require(:user).permit(:name, :login, :manager)
  end


end