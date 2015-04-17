class SessionsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    redirect_to '/auth/github'
  end

  def create
    auth_hash = request.env['omniauth.auth']
    user = User.find_by(github_id: auth_hash[:uid]) || User.create_by_github(auth_hash)
    sign_in(user)
    redirect_to root_url, notice: 'ログインしました'
  end

  def destroy
    sign_out
    redirect_to root_url, notice: 'ログアウトしました'
  end
end