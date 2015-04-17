class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_post, only: %i(index)
  # before_action :set_comment, only: []

  def index
    @comments = @post.comments
  end

  private
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_post
    @post = @user.posts.find(params[:post_id])
  end

  # def set_comment
  #   @comment = @post.comments.find(params[:id])
  # end
end