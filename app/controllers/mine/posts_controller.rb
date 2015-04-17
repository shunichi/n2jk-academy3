class Mine::PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.js { render }
      else
        format.js { render 'failed' }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.js { render  }
      else
        format.js { render 'failed' }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.js { render }
    end
  end

  private

  def set_post
    @post = current_user.posts.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body)
  end
end
