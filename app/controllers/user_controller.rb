class UserController < ApplicationController
	#注册账户的动作跳过过滤器。
	skip_before_action :identify, only: [:create]
	# #设置前置过滤器，首先确定user。
	before_action :set_user, only: [:show, :update]
	def create
		@user = User.new(params_user)
		@user.avatar = params[:file]
			if @user.save
				render json: {code: 0, user: @user}
			else
				render json: {code: 3001}
			end
	end

	def show
		if @user
		    render json: {code: 0, user: @user}
		else
			render json: {code: 3001}
		end
	end

	def update
		@user.avatar = params[:file]
		if @user.update(params_user_need)
			render json: {code: 0, user: @user}
		else
			render json: {code: 3001}
		end
	end

	private
		def params_user
			params.permit(:username, :password, :nickname, :sex, :introduction, :avatar)
		end

		def params_user_need
			params.permit(:password, :nickname, :sex, :introduction, :avatar)
		end

		 def set_user
			@user = User.read_cache	
		 end
end

