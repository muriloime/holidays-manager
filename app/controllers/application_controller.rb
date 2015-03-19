class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :is_logged_in, :holidays_pending

  include SessionsHelper

  def is_logged_in
    if !logged_in?
      render 'sessions/new'
    end
  end

  def holidays_pending
    if logged_in?
      if current_user.manager?
        @holidays_pending = Holiday.where(status: "Pending").count
      end
    end
  end

end
