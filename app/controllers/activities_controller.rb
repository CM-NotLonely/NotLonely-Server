class ActivitiesController < ApplicationController
	
  #在某个圈子里面创建活动。
	def create
    @activity = Activity.create(activity_params) do |a|
      a.user_id = session[:user_id]
    end
		if @activity
			render json: {code: 0, activity: @activity.exp(:created_at, :updated_at, :user_id)}
		else
			render json: {code: 3001, msg: '创建活动失败'}
		end
	end
	
	#查看某个活动的情况。
	def show
		@activity = Activity.selected!("created_at", "updated_at", "user_id").find(params[:id])
		if @activity
		    render json: {code: 0, activity: @activity}
		else
		    render json: {code: 3001, msg: '显示活动失败'}
		end
	end
	
	#查看指定圈子里的所有活动。
	def index
		@activities = Activity.selected!("created_at", "updated_at", "user_id").where(group_id: params[:group_id])
		if @activities
			render json: {code: 0, activities: @activities}
		else
			render json: {code:3001, msg: '显示该圈子的所有活动失败'}
		end
	end
	
	#删除指定的活动。
	def destroy
		if Activity.exists?(id: params[:id], user_id: session[:user_id]) && Activity.delete(params[:id])
			render json: {code: 0, msg: '删除成功'}
		else
			render json: {code: 3001, msg: '删除该活动失败'}
		end
	end
	
	#更新指定的活动。
	def update
			if Activity.exists?(id: params[:id], user_id: session[:user_id]) && @activity = Activity.update(params[:id], activity_params)
				render json: {code: 0, activity: @activity.exp(:created_at, :updated_at, :user_id)}
			else
				render json: {code: 3001, msg: '更新失败'}
      end
	end

	#显示赞数前10的活动
	def index2
		if @activities = Activity.selected!("created_at", "updated_at", "user_id").order('likes_count DESC').limit(10)
		  render json: {code: 0, activities: @activities}
    else
      render json: {code: 3001, msg: '尚未存在活动，赶紧成为创建活动第一人吧'}
    end
	end
  
  def avatar_send
    response.headers['X-Accel-Redirect'] = "/uploads/" + params[:path]
  end

	private
	def activity_params
		params.permit(:title, :location, :cost, :detail, :time, :group_id)
	end

end
