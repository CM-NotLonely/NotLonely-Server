class ActivitiesController < ApplicationController
	#在某个圈子里面创建活动。
	def create
		@activity = Activity.new(activity_params)
    @activity.group_id = params[:group_id]
		@activity.user_id = session[:user_id]
		if @activity.save
			render json: {code: 0, activity: @activity}
		else
			render json: {code: 3001, msg: '创建活动失败'}
		end
	end
	
	#查看某个活动的情况。
	def show
		@activity = Activity.find(params[:id])
		if @activity
		    render json: {code: 0, activity: @activity}
		else
		    render json: {code: 3001, msg: '显示活动失败'}
		end
	end
	
	#查看指定圈子里的所有活动。
	def index
		@activities = Activity.where(group_id: params[group_id])
		if @activities
			render json: {code: 0, activities: @activities}
		else
			render json: {code:3001, msg: '显示该圈子的所有活动失败'}
		end
	end
	
	#删除指定的活动。
	def destroy
		@activity = Activity.find(params[:id])
		if @activity.user_id == session[:user_id]
			@activity.destroy
			render json: {code: 0, msg: '删除成功'}
		else
			render json: {code: 3001, msg: '删除该活动失败'}
		end
	end
	
	#更新指定的活动。
	def update
		@activity = Activity.find(params[:id])
		if @activity.user_id == session[:user_id]
			if @activity.update(activity_params)
				render json: {code: 0, activity: @activity}
			else
				render json: {code: 3001, msg: '更新失败'}
			end
		else
			render json: {code: 3001, msg: '非本人没有权限修改该用户资料'}
		end
	end

	#显示赞数前10的活动
	def index2
		@activities = Activity.order('likes_count DESC').limit(10)
		render json: {code: 0, activities: @activities}
	end

	private
	def activity_params
		params.permit(:title, :location, :cost, :detail, :time)
	end

end
