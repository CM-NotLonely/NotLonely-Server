class GroupApplyController < ApplicationController
	#设置过滤器找到group_applies.
	before_action :set_group_applies, only: [:index, :sub_index]
	# 登录用户申请加入某个指定的圈子。
	def create
		@group_apply = GroupApply.new(params_group_apply) 
		@group_apply.user_id = session[:user_id]
		@group_apply.isagree = 0
		@group_apply.save
		render json: {code: 0, msg: "申请成功，等待对方回复中", group_apply: @group_apply}
	end

	# 返回登录用户的所有被申请加入的圈子的列表。
	def index
		@groups = @user.groups
		@group_applies = GroupApply.where(group_id: @groups.ids,isagree: 0)
		if @group_applies
			render json: {code: 0, group_applies: @group_applies}
		else
			render json: {code: 3001, msg: "尚未收到任何申请哦"}
		end
	end

	# 登录用户回复是否同意圈子申请。
	def update
		@group_apply = GroupApply.find(params[:id])
		if @group_apply.group.user_id == session[:user_id]
			if @group_apply.update(params_isagree)
				render json: {code: 0, group_apply: @group_apply}
			else
				render json: {code: 3001, msg: "回复失败，可能是你没有明确回复是否同意"}
			end
		else
			render json: {code: 3001, msg: "孩子，不要再迷失方向了"}
		end
	end

	# 某一圈子申请的详情。
	def show
		@group_apply = GroupApply.find(params[:id])
		if @group_apply
			render json: {code: 0, group_apply: @group_apply}
		else
			render json: {code: 3001}
		end
	end

	# 显示用户已经申请加入的圈子。
	def sub_index
		@group_applies = GroupApply.select(:group_id).where(user_id: @user.id, isagree: 2)
		if @group_applies
			@groups = Group.where(id: @group_applies)
			render json: {code: 0, groups: @groups}
		else
			render json: {code: 3001, msg: "尚未加入任何圈子"}
		end
	end

	private
		# 设置参数白名单。
		def params_group_apply
			params.permit(:group_id)
		end

		def params_isagree
			params.permit(:isagree, :id)
		end

		def set_group_applies
			@user = User.read_cache
		end
end
