class LikesController < ApplicationController
	#点赞
	def create
		#@activity = Activity.select(:id).where(id: params[:activity_id])
		#like = activity.likes.new
		#like.user_id = session[:user_id]
		#count = activity.group.likes_count# could be better
		#count2 = activity.likes_count# could be better
		if @like.create(user_id: session[:user_id], activity_id: params[:activity_id])
			#activity.group.update(likes_count: count+1)
			#activity.update(likes_count: count+1)
			render json: {code: 0, like: @like}
		else
			render json: {code: 3001, msg: '不要重复点赞'}
		end
	end

	#取消赞
	def destroy
		#activity = Activity.find(params[:activity_id])
		#like = activity.likes.find_by(user_id: session[:user_id])
	#	count=activity.group.likes_count# could be better
	#	count2=activity.likes_count# could be better
  @like = Like.where(user_id: session[:user_id], activity_id: params[:activity_id])
		if @like && @like.destroy
			#activity.group.update(likes_count: count-1)
			#activity.update(likes_count: count-1)
			render json: {code: 0, msg: "取消赞成功"}
		else
			render json: {code: 3001, msg: '取消赞失败'}
		end
	end

end