class Mine::UsersController < ApplicationController

  def edit
  end

  def update
    respond_to do |format|
      if current_user.update(user_params)
        format.html { redirect_to root_url }
        format.js { render }
      else
        format.html { render :edit }
        format.js { render 'shared/failed' }
      end
    end
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :email, :mail_notification)
  end
end