class ActivitiesController < ApplicationController
	
  #在某个圈子里面创建活动。
	def create
    @activity = Activity.create(activity_params) do |a|
      a.user_id = session[:user_id]
      a.group_id = params[:group_id]
    end
		if @activity
			render json: {code: 0, activity: @activity.exp(:created_at, :updated_at)}
		else
			render json: {code: 3001, msg: '创建活动失败'}
		end
	end
	
  #添加默认圈子活动
  def create_default
    @activity = Activity.create(default_params) do |a|
      a.user_id = session[:user_id]
      a.group_id = 0
    end
		if @activity
			render json: {code: 0, activity: @activity.exp(:created_at, :updated_at)}
		else
			render json: {code: 3001, msg: '创建活动失败'}
		end
  end
  
	#查看某个活动的情况。
	def show
		@activity = Activity.selected!("created_at", "updated_at").find(params[:id])
		if @activity
		    render json: {code: 0, activity: @activity}
		else
		    render json: {code: 3001, msg: '显示活动失败'}
		end
	end
	
	#分页查看指定圈子里的所有活动。
	def all
		@activities = Activity.selected!("created_at", "updated_at").where(group_id: params[:group_id]).limit(10).offset(10 * params[:number].to_i)
		if @activities
			render json: {code: 0, activities: @activities}
    end
  rescue
			render json: {code:3001, msg: '显示该圈子的所有活动失败'}
	end
	
	#删除指定的活动。
	def destroy
		if Activity.exists?(id: params[:activity_id], user_id: session[:user_id]) && Activity.delete(params[:activity_id])
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

	#分页显示赞数高的活动
	def top
		@activities = Activity.selected!("created_at", "updated_at").order('likes_count DESC').limit(10).offset(10 * params[:number].to_i)
    if @activities
      render json: {code: 0, activities: @activities}
    end
    
    rescue
      render json: {code: 3001, msg: @activities.errors.full_message}
	end
  
  def avatar_send
    response.headers['X-Accel-Redirect'] = "/uploads/" + params[:path]
  end

	private
	  def activity_params
		  params.permit(:title, :location, :cost, :detail, :time, :count)
	  end
    
    def default_params
      params.permit(:title, :location, :cost, :detail, :time, :count)
    end

end
