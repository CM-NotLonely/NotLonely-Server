class PictureController < ApplicationController
  def new
  	@user = User.new
  end

  def create
    # render plain: params[:user].inspect
    
  	@user = User.new(params_user)
    @user.avatar = params[:file]
    @user.save
    redirect_to picture_show_path(id: @user.id)
  end

  def show
  	@user = User.find(params[:id])
  end

  private
  	def params_user
  		params.require(:user).permit(:avatar)
  	end
end
