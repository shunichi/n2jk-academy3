class Mine::PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  def new
  end

  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to [current_user, @post] }
        format.js { render }
      else
        format.html { render :new }
        format.js { render 'shared/failed' }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.js { render  }
      else
        format.js { render 'shared/failed' }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
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
