class FollowController < ApplicationController
	# 关注。
	def create
		if Follow.new(user_follow_id: session[:user_id], user_followed_id: params[:user_followed_id]).save
			render json: {code: 0, msg: "关注成功"}		
		else
			render json: {code: 3001, msg: "关注失败，可能是对方设置了禁止关注"}		
		end		
	end

	# 取消关注。
	def destroy
		if Follow.exists?(user_follow_id: session[:user_id], id: params[:id]) && Follow.delete(params[:id])
			render json: {code: 0, msg: "取消关注成功"}
		else
			render json: {code: 3001, msg: "取消关注失败"}
		end
	end

	# 登录用户所有关注的人。
	def index
		@follows = Follow.select(:user_followed_id).where(user_follow_id: session[:user_id])
		if @follows != []
			@users = User.select(:nickname, :sex, :introduction, :avatar).where(id: @follows)
			if @users
				render json: {code: 0, users: @users}
			else
				render json: {code: 3001, msg: "你木有关注人"}
			end
		else
			render json: {code: 3001, msg: "你木有关注人"}
		end
	end
end
