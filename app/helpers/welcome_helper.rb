module WelcomeHelper

  def logged_in?
    cookies.signed[:login_signed].nil?
  end

end
