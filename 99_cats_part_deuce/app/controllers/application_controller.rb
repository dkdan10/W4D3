class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    debugger
    loggedInSession = SessionToken.find_by(session_token: session[:session_token])
    if loggedInSession
      user = loggedInSession.user
    else
      user = nil
    end
    @current_user ||= user

  end

  def logged_in?
    !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!current_user
    # bangbangbangbangbangbangbangbangbangbang
  end

  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  def already_logged_in
    redirect_to cats_url if logged_in?
  end

  def login!(user)
    session[:session_token] = user.generate_session_token
    # session[:session_token] = user.reset_session_token!
  end

  def logout!
    SessionToken.find_by(session_token: session[:session_token]).destroy!
    @current_user = nil
    session[:session_token] = nil
  end

end
