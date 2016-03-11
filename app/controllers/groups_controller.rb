class GroupsController < ApplicationController
	#设置前置过滤器确保前提是对的。
	before_action :set_user
	
	#已登录的用户创建新圈。
	def create
		@group = @user.groups.new(group_params)
		if @group.save
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001}
		end
	end
	
	#查看所有用户创建的所有圈子。
	def index2
		@groups=Group.all
		if @groups
			render json: {code: 0, groups: @groups}
		else
			render json: {code: 3001}
		end
	end
	

	#查看已登录用户的某个已创建圈子的信息。
	def show
		@group = @user.groups.find(params[:id])
		if @group
		    render json: {code: 0, group: @group}
		else
			render json: {code: 3001}
		end
	end
	
	#更新已登录用户创建的某个圈子。
	def update
		@group = @user.groups.find(params[:id])
		if @group.update(group_params)
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001}
		end
	end
	
	#删除已登录用户的某个已创建的圈子。
	def destroy
		@group = @user.groups.find(params[:id])
		if @group.destroy
			render json: {code: 0}
		else
			render json: {code: 3001}
		end
	end
	
	#查看已登录用户创建的所有圈子。
	def index
		@groups = @user.groups
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
	
	#增加一个判断，只有当@user为空时才去查找已登录用户的信息。
	def set_user
		unless @user
			@user = User.find_by(id: session[:user_id])
		end
	end
end
