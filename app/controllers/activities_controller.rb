class ActivitiesController < ApplicationController
	def create
		@user=User.find_by(id: session[:user_id])
		@group=Group.find(params[:group_id])
		@activity=@group.activities.new(activity_params) # this line can be better!
		@activity.user_id=@user.id
		if @activity.save
			render json: {code: 0, activity: @activity}
		else
			render json: {code: 3001}
		end
	end

	def show
		@activity=Activity.find(params[:id])
		if @activity
		    render json: {code: 0, activity: @activity}
		else
			render json: {code: 3001}
		end
	end

	def index
		@group=Group.find(params[:group_id])
		@activities=@group.activities
		if @activities
			render json: {code: 0, activities: @activities}
		else
			render json: {code:3001}
		end
	end

	def destroy
		@activity=Activity.find(params[:id])
		if @activity.destroy
			render json: {code: 0}
		else
			render json: {code: 3001}
		end
	end

	def update
		@activity=Activity.find(params[:id])
		if @activity.update(activity_params)
			render json: {code: 0, activity: @activity}
		else
			render json: {code: 3001}
		end
	end

	private
	def activity_params
		params.permit(:title, :location, :cost, :detail, :time)
	end

end