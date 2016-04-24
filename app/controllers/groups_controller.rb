class GroupsController < ApplicationController
  	
	#已登录的用户创建新圈。
	def create
    @group = Group.new(group_params)
    @group.user_id = session[:user_id]
		render json: {code: 0, group: @group} if @group.save
  rescue
    render json: {code: 3001, msg: @group.error.full_messages}
  end
	
	#查看所有圈子。
	def index2
    @groups = Group.all
	end
	

	#查看已登录用户的某个已创建圈子的信息。
	def show
		@group = Group.where(id: params[:id], user_id: session[:user_id])
		if @group
		    render json: {code: 0, group: @group}
		else
			render json: {code: 3001, msg: '圈子不存在'}
		end
	end
	
	#更新已登录用户创建的某个圈子。
	def update
		@group = Group.where(id: params[:id], user_id: session[:user_id])
		if @group.update(group_params)
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001, msg: '更新圈子失败'}
		end
	end
	
	#删除已登录用户的某个已创建的圈子。
	def destroy
		@group = Group.where(id: params[:id], user_id: session[:user_id])
		if @group.destroy
			render json: {code: 0, msg: '删除圈子成功'}
		else
			render json: {code: 3001, msg: '删除某圈子失败'}
		end
	end
	
	#查看登录用户创建的所有圈子。
	def index
		@groups = Group.where(user_id: session[:user_id])
		if @groups
			render json: {code: 0, groups: @groups}
		else
			render json: {code:3001, msg: '查看我的所有圈子失败'}
		end
	end

	#显示赞数高的前十个圈子，强力优化性能
	def index3
		@groups = Group.order('likes_count DESC').limit(10)
    if @groups
		  render json: {code: 0, groups: groups}
    else
      render json: {code: 3001, msg: '目前尚未有圈子'}
    end
	end

	private
		def group_params
			params.permit(:title, :introduction, :avatar, :id)
		end
end