class GroupsController < ApplicationController
	def new

	end

	def create
		@group=Group.new(group_params)
		if @group.save

		else

		end
	end

	private
	def group_params
		params.require(:group).permit(:title, :introduction, :heading)
	end

end