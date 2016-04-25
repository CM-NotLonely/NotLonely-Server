class FollowController < ApplicationController
	# 关注。
	def create
		#@follow = Follow.new
		#@follow.user_follow_id = @user.id
		#@follow.user_followed_id = params[:user_followed_id]
		if @follow = Follow.create(user_follow_id: session[:user_id], user_followed_id: params[:user_followed_id])
			render json: {code: 0, msg: "关注成功", follow: @follow}		
		else
			render json: {code: 3001, msg: "关注失败，可能是对方设置了禁止关注"}		
		end		
	end

	# 取消关注。
	def destroy
		@follow = Follow.where(user_follow_id: @user.id, id: params[:id]).take
		if @follow.destroy
			render json: {code: 0, msg: "取消关注成功"}
		else
			render json: {code: 3001, msg: "取消关注失败"}
		end
	end

	# 登录用户所有关注的人。
	def index
		@follows = Follow.select(:user_followed_id).where(user_follow_id: @user.id)
		if @follows != []
			@users = User.where(id: @follows)
			if @users != []
				render json: {code: 0, users: @users}
			else
				render json: {code: 3001, msg: "你的关注人清单是0哦"}
			end
		else
			render json: {code: 3001, msg: "你的关注人清单是0哦"}
		end
	end
end
