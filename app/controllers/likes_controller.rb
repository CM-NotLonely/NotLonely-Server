class LikesController < ApplicationController
	#点赞
	def create
		activity=Activity.find(params[:activity_id])
		like=activity.likes.new
		like.user_id=session[:user_id]
		if like.save
			render json: {code: 0, like: like}
		else
			render json: {code: 3001}
		end
	end

	#取消赞
	def destroy
		activity=Activity.find(params[:activity_id])
		like=activity.likes.find_by(user_id: session[:user_id])
		if like && like.destroy
			render json: {code: 0}
		else
			render json: {code: 3001}
		end
	end

end