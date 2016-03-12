class FollowController < ApplicationController
	# 设置前过滤器。
	before_action :set_user
	# 关注。
	def cretae
		@follow = Follow.new
		@follow.user_follow_id = @user.id
		@follow.user_followed_id = params[:user_followed_id]
		if @follow.save
			render json: {code: 0, follow: @follow}		
		else
			render json: {code: 3001}		
		end		
	end

	# 取消关注。
	def destroy
		@follow = Follow.where(user_follow_id: @user.id, id: params[:id])
		if @follow.destroy
			render json: {code: 0}
		else
			render json: {code: 3001}
		end
	end

	private
		def set_user
			@user = User.find_by(id: session[:user_id])
		end
end
