class GroupsController < ApplicationController
	#已登录的用户创建新圈
	def create
    @group = Group.new(params_group)
    @group.user_id = session[:user_id]
		if @group.save
      render json: {code: 0, group: @group.exp(:created_at, :updated_at)}
    else
      render json: {code: 3001, msg: @group.errors.full_messages}
    end
  end
	
	#分页查看所有圈子
	def all
    if @groups = Group.selected!("created_at", "updated_at", "headimg", "user_id").limit(10).offset(10 * params[:number])
      render json: {code: 0, groups: @groups}
    else
      render json: {code: 3001, msg: '尚未存在圈子，赶快成为创建圈子第一人吧'}
    end
	end
	

	#查看已登录用户的某个已创建圈子的信息
	def show
		@group = Group.selected!("headimg", "created_at", "updated_at").where(id: params[:id], user_id: session[:user_id])
		if @group
		    render json: {code: 0, group: @group}
		else
			  render json: {code: 3001, msg: '圈子不存在'}
		end
	end
	
	#更新已登录用户创建的某个圈子
	def update
		if Group.exists?(id: params[:id], user_id: session[:user_id]) && (@group = Group.update(params[:id], group_params))
			render json: {code: 0, group: @group.exp(:created_at, :updated_at, :headimg, :user_id)}
		else
			render json: {code: 3001, msg: '更新圈子失败'}
		end
	end
	
	#删除已登录用户的某个已创建的圈子
	def destroy
		if Group.exists?(id: params[:id], user_id: session[:user_id]) && Group.delete(params[:id])
			render json: {code: 0, msg: '删除圈子成功'}
		else
			render json: {code: 3001, msg: '删除圈子失败'}
		end
	end
	
	#分页查看登录用户创建的所有圈子
	def index
		@groups = Group.selected!("created_at", "updated_at", "headimg", "user_id").where(user_id: session[:user_id]).limit(10).offset(10 * params[:number])
		if @groups
			render json: {code: 0, groups: @groups}
		else
			render json: {code:3001, msg: '查看我的所有圈子失败'}
		end
	end

	#分页显示赞数高的活动
	def top
		@groups = Group.selected!("created_at", "updated_at", "headimg", "user_id").order('likes_count DESC').limit(10).offset(10 * params[:number])
    if @groups
		  render json: {code: 0, groups: @groups}
    end
  rescue
      render json: {code: 3001, msg: @groups.errors.full_message}
	
  end

	private
		def group_params
			params.permit(:title, :introduction, :avatar, :id)
		end
    
    def params_group
      params.permit(:title, :introduction, :avatar)
    end
end