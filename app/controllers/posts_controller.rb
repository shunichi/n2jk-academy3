class PostsController < ApplicationController
  before_action :set_user
  before_action :set_post

  def show
  end

  def read
    head :no_content unless @post.read_by(current_user)
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_post
      @post = @user.posts.find(params[:id])
    end
end
