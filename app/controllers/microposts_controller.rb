class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

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
  end

  private
    
    def post_params
      params.require(:micropost).permit(:content)
    end

end
