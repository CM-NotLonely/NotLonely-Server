class UserController < ApplicationController
	#注册账户的动作跳过过滤器。
	skip_before_action :identify, only: [:create]
	def create
		@user = User.new(params_user)
		@user.avatar = params[:file]
     	# @user.username = params[:user][:username]
      # 	@user.password = params[:user][:password]
      # 	@user.sex = params[:user][:sex]
      # 	@user.introduction = params[:user][:introduction]
      # 	@user.nickname = params[:user][:nickname]
		#@user = User.new(params_user)
		#@user.avatar = params[:file]
			if @user.save
				render json: {code: 0, user: @user}
			else
				render json: {code: 3001}
			end
	end

	def show
		@user = User.find(session[:user_id])
		if @user
		    render json: {code: 0, user: @user}
		else
			render json: {code: 3001}
		end
	end

	def update
		@user = User.find(session[:user_id])
		if @user.update(params_user)
			render json: {code: 0, user: @user}
		else
			render json: {code: 3001}
		end
	end

	private
		def params_user
			params.permit(:username, :password, :nickname, :sex, :introduction, :avatar)
		end
end
