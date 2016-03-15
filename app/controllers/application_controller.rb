class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :logged_in?

  def require_login
    unless cookies.signed[:login_signed]
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end

  def logged_in?
    cookies.signed[:login_signed].nil? ?  false : true
  end

  def current_user
    return unless logged_in?
    @current_user ||= User.find(cookies.signed[:login_signed])
  end


end
