class LikesController < ApplicationController
	#点赞
	def create
		if @like.create(user_id: session[:user_id], activity_id: params[:activity_id])
			render json: {code: 0, like: @like}
		else
			render json: {code: 3001, msg: '不要重复点赞'}
		end
	end

	#取消赞
	def destroy
  @like = Like.where(user_id: session[:user_id], activity_id: params[:activity_id])
		if @like && @like.destroy
			render json: {code: 0, msg: "取消赞成功"}
		else
			render json: {code: 3001, msg: '取消赞失败'}
		end
	end

end