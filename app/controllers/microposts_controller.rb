class MicropostsController < ApplicationController
  before_action :correct_user,   only: :destroy

  before_action :is_current_user_in, only: :index

  def is_current_user_in
    current_user?
  end

  def index
    @micropost  = current_user.microposts.build
    @feed_items = Micropost.all.paginate(page: params[:page])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = "Micropost created!"
      redirect_to microposts_path
    else
      flash[:danger] = "Micropost Feed must be 1 to 300 characters"
      redirect_to microposts_path
    end
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end

end
