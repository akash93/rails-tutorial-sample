class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: [:destroy]

  def create
    @post = current_user.microposts.build(post_params)
    if @post.save
      flash[:success] = 'Post created'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'Post deleted'
    redirect_to request.referrer || root_url
  end

  private
    
    def post_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @post = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

end
