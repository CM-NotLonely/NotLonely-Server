class GroupsController < ApplicationController
	#设置前置过滤器确保前提是对的。
	before_action :set_user
	
	#已登录的用户创建新圈。
	def create
		@group = @user.groups.new(group_params)
		if @group.save
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001, msg: '创建圈子失败'}
		end
	end
	
	#查看所有用户创建的所有圈子。
	def index2
		@groups=Group.all
		if @groups
			render json: {code: 0, groups: @groups}
		else
			render json: {code: 3001, msg: '查看所有用户创建的所有圈子失败'}
		end
	end
	

	#查看已登录用户的某个已创建圈子的信息。
	def show
		@group = @user.groups.find(params[:id])
		if @group
		    render json: {code: 0, group: @group}
		else
			render json: {code: 3001, msg: '查看某用户某指定的圈子失败'}
		end
	end
	
	#更新已登录用户创建的某个圈子。
	def update
		@group = @user.groups.find(params[:id])
		if @group.update(group_params)
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001, msg: '更新某圈子失败'}
		end
	end
	
	#删除已登录用户的某个已创建的圈子。
	def destroy
		@group = @user.groups.find(params[:id])
		if @group.destroy
			render json: {code: 0}
		else
			render json: {code: 3001, msg: '删除某圈子失败'}
		end
	end
	
	#查看已登录用户创建的所有圈子。
	def index
		@groups = @user.groups
		if @groups
			render json: {code: 0, groups: @groups}
		else
			render json: {code:3001, msg: '查看某用户的所有圈子失败'}
		end
	end

	#显示赞数高的前十个圈子，强力优化性能
	def index3
		if Group.all.empty?
			return render json: {code: 3001, msg: '显示赞数高的前十个圈子失败，因为圈子为空'}
		end
		groups=(Group.order 'likes_count DESC').limit(10)
		render json: {code: 0, groups: groups}
	end

	private
		def group_params
			params.permit(:title, :introduction, :avatar, :id)
		end
	
		def set_user
			if @user.nil?
				@user = User.read_cache
			end
		end
end