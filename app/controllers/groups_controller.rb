class GroupsController < ApplicationController
	before_action :set_user
	def create
		@group = @user.groups.new(group_params)
		if @group.save
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001}
		end
	end

	private
	def group_params
		params.permit(:title, :introduction, :avatar)
	end

	def set_user
		@user = User.find_by(id: session[:user_id])
	end
end