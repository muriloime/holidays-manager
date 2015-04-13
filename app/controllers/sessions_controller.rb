class SessionsController < ApplicationController
  skip_before_action :is_logged_in , [:create, :new]

  def new
    if logged_in?
      redirect_to general_holidays_path
    end
  end

  def create
    user = User.find_by(login: params[:session][:login].downcase)
    if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in(user)
      redirect_to general_holidays_path
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
  end


end
