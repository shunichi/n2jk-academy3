class Mine::CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i(update destroy)

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        NotificationMailer.new_comment(@comment).deliver_now!
        format.js { render }
      else
        format.js { render 'shared/failed' }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.js { render }
      else
        format.js { render 'shared/failed' }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.js { render }
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end