class SessionsController < ApplicationController
  def new
    redirect_to '/auth/github'
  end

  def create
  end

  def destroy
    sign_out
  end
end