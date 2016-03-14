class LikesController < ApplicationController
	#点赞，我觉得用数据库来检验是否重复点赞比较好些
	def create
		activity = Activity.find(params[:activity_id])
		like = activity.likes.new
		like.user_id = session[:user_id]
		user=User.find_by(id: session[:user_id])
		if user.likes.find_by(activity_id: activity.id)
			render json: {code: 3001, message: '不能重复点赞'}
		elsif like.save
			render json: {code: 0, like: like}
		else
			render json: {code: 3001}
		end
	end

	#取消赞
	def destroy
		activity = Activity.find(params[:activity_id])
		like = activity.likes.find_by(user_id: session[:user_id])
		if like && like.destroy
			render json: {code: 0}
		else
			render json: {code: 3001}
		end
	end

end