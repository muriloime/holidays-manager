class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_action :is_logged_in

  include SessionsHelper

  def is_logged_in
    if !logged_in?
      render 'sessions/new'
    end
  end

end
