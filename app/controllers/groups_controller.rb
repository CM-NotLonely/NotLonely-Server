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

	#显示赞数高的前十个圈子，优化了点性能
	def index3
		activities=Activity.all
		count=Group.count
		like_counts=Array.new(0, count)
		groupss=Group.all
		for i in 1..count
			num=0
			groupss.find(i).activities.all.each do |a|
				num+=a.likes.count
			end
			like_counts[i]=num
		end

		temp=Array.new like_counts

		t=0
		for i in 1..count-1
			for j in 1..count-i-1
				if like_counts[j]<like_counts[j+1]
					t=like_counts[j]
					like_counts[j]=like_counts[j+1]
					like_counts[j+1]=t
				end
			end
		end

		groups=[]
		for i in 1..count
			for j in 1..count
				if like_counts[i]==temp[j]
					temp[j]=-1
					break
				end
			end
			group=groupss.find(j)
			groups[i]=group
		end
		groups=groups.first 10

		render json: {groups: groups}
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