module SessionMethods
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :user_signed_in?
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session[:user_id] = nil
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    !current_user.nil?
  end

  def authenticate_user!
    redirect_to root_url, alert: 'ログインしてください' unless user_signed_in?
  end
end
