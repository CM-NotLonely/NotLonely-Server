class ActivityApplyController < ApplicationController
	#设置过滤器找到acticity_applies.
	before_action :set_activity_applies, only: [:index, :sub_index]
	# 生成一个新的待回复的活动申请。
	def create
		@activity_apply = ActivityApply.new(params_activity_apply) 
		@activity_apply.user_id = session[:user_id]
		@activity_apply.isagree = 0
		@activity_apply.save
		render json: {code: 0, msg: "申请成功，等待对方回复", activity_apply: @activity_apply}
	end

	# 返回登录用户的所有被申请加入的活动的列表。
	def index
		@activities = @user.activities
		@activity_applies = ActivityApply.where(id: @activities.ids,isagree: 0)
		if @activity_applies
			render json: {code: 0, activity_applies: @activity_applies}
		else
			render json: {code: 3001, msg: "你尚未收到任何申请"}
		end
	end

	# 登录用户回复是否同意活动申请。
	def update
		@activity_apply = ActivityApply.find(params[:id])
		if @activity_apply.activity.user_id == session[:user_id]
			if @activity_apply.update(params_isagree)
				render json: {code: 0, msg: "处理活动申请成功", activity_apply: @activity_apply}
			else
				render json: {code: 3001, msg: "处理活动申请失败"}
			end
		else
			render json: {code: 3001, msg: "孩子，你是不是迷失方向了"}
		end
	end

	# 某一活动申请的详情。
	def show
		@activity_apply = ActivityApply.find(params[:id])
		if @activity_apply
			render json: {code: 0, activity_apply: @activity_apply}
		else
			render json: {code: 3001, msg: "该活动申请不存在"}
		end
	end

	# 显示用户已经加入的活动。
	def sub_index
		@activity_applies = ActivityApply.select(:activity_id).where(user_id: @user.id, isagree: 2)
		if @activity_applies
			@activities = Activity.where(id: @activity_applies)
			render json: {code: 0, activities: @activities}
		else
			render json: {code: 3001, msg: "你尚未加入任何活动"}
		end
	end

	private
		# 设置参数白名单。
		def params_activity_apply
			params.permit(:activity_id)
		end

		def params_isagree
			params.permit(:isagree, :id)
		end

		def set_activity_applies
			@user = User.read_cache
		end
end
