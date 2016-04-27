class GroupInviteController < ApplicationController
	
  # 登录用户申请邀请某人加入某个指定的圈子。
	def create
		if @group_invite.create(params_group_invite, group_id: params[:group_id], user_invited_id: params[:user_invited_id], isagree: 0)
		  render json: {code: 0, msg: "申请发送成功", group_invite: @group_invite}
    else
      render json: {code: 3001, msg: @group_invite.error.full_messages}
    end
	end

	# 返回登录用户的所有被邀请加入的圈子的列表。
	def index
		@group_invites = GroupInvite.where(user_invited_id: @user.id, isagree: 0)
		if @group_invites
			render json: {code: 0, group_invites: @group_invites}
		else
			render json: {code: 3001, msg: "你还没有加入任何一个圈子"}
		end
	end

	# 登录用户回复是否同意圈子邀请。
	def update
		@group_invite = GroupInvite.find(params[:id])
		if @group_invite.user_invited_id == session[:user_id]
			if @group_invite.update(params_isagree)
				render json: {code: 0, group_invite: @group_invite}
			else
				render json: {code: 3001, msg: "回复失败，可能是没有明确回复是否同意"}
			end
		else
			render json: {code: 3001, msg: "权限不足，无法修改"}
		end
	end

	# 某一圈子邀请的详情。
	def show
		@group_invite = GroupInvite.find_by(id: params[:id])
		@group = Group.find(@group_invite.group_id)
		if @group
			render json: {code: 0, group: @group}
		else
			render json: {code: 3001}
		end
	end

	# 显示用户已经被邀请加入的圈子。
	def sub_index
		@group_invites = GroupInvite.select(:group_id).where(user_invited_id: @user.id, isagree: 2)
		if @group_invites
			@groups = Group.where(id: @group_invites)
			render json: {code: 0, groups: @groups}
		else
			render json: {code: 3001, msg: "你尚未加入任何一个圈子"}
		end
	end

	private
		# 设置参数白名单。
		def params_group_invite
			params.permit(:group_id, :user_invited_id)
		end

		def params_isagree
			params.permit(:isagree, :id)
		end

end
