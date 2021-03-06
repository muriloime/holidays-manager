module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_user?
     redirect_to root_url if @current_user != User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
    redirect_to root_url
  end

  def manager_action
    if current_user.manager == false
      redirect_to root_url
    end
  end

  def manager?
    current_user.manager == true
  end

  def count_holidays_pending
    if logged_in?
      if current_user.manager?
        return Holiday.where(status: "Pending").count
      end
    end
  end

end
