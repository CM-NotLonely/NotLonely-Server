class GroupsController < ApplicationController
	before_action :set_user
	def create
		@group = @user.groups.new(group_params)
		if @group.save
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001}

	before_action :set_group, only: [:show]
	def create
		@user=User.find_by(id: session[:user_id])
		@group=@user.groups.new(group_params)
		if @group.save
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001}
		end
	end

	def show
		if @group
		    render json: {code: 0, group: @group}
		else
			render json: {code: 3001}
		end
	end

	def update
		@group=Group.find(params[:id])
		if @group.update(params_group_need)
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001}
		end
	end

	def destroy
		@group=Group.find(params[:id])
		if @group.destroy
			render json: {code: 0}
		else
			render json: {code: 3001}
		end
	end

	def index
		@user=User.find_by(id: session[:user_id])
		@groups=@user.groups
		if @groups
			render json: {code: 0, groups: @groups}
		else
			render json: {code:3001}
		end
	end

	private
	def group_params
		params.permit(:title, :introduction, :avatar)

	end

	def set_group
		@user=User.find_by(id: session[:user_id])
		@group=@user.groups.find_by(params[:id])
	end

	def params_group_need
		params.permit(:title, :introduction, :avatar)
	end

	def set_user
		@user = User.find_by(id: session[:user_id])
	end
end