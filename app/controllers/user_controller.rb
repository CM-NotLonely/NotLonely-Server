class UserController < ApplicationController
	skip_before_action :identify, only: [:create, :show]
	
	def create
		@user = User.new(params_user)
		render json: {code: 0, msg: "注册成功。"} if @user.save!
	rescue
		 	render json: {code: 3001, msg: @user.errors.full_messages}
	end

	def show
		render json: {code: 0, user: @user} if @user = User.find(params[:id]).as_json(except: [:id, :username, :password_digest, :created_at, :updated_at])
	rescue
		render json: {code: 3001, msg: "无法找到该用户"}
	end

	def update
		render json: {code: 0, msg: "更改个人信息成功"} if User.find(session[:user_id]).update!(params_user_need)
	rescue 
		render json: {code: 3001, msg: "更改个人信息失败"}
	end

	def update_head_image
		render json: {code: 0, msg: "更改个人头像成功"} if User.find(session[:user_id]).update!(avatar_params)
	 rescue
	 	render json: {code: 3001, msg: "更改个人头像失败,只允许Jpg,Jpeg,Gif,Png格式的图片"}
	end

	def update_password
		@user = User.find(session[:user_id])
		render json: {code: 0, msg: "更改密码成功"} if @user.update!(password_params)
	rescue 
		render json: {code: 3001, msg: @user.errors.full_messages}
	end

	def show_oneself
		render json: {code: 0, user: current_user}
	end

	private
		def params_user
			params.permit(:username, :password, :password_confirmation, :nickname, :sex, :introduction, :avatar)
		end

		def params_user_need
			paramsd = params.permit(:nickname, :sex, :introduction, :status)
			paramsd[:status] = 0
			paramsd
		end

		def avatar_params
			paramsd = params.permit(:avatar, :status)
			paramsd[:status] = 0
			paramsd
		end

		def password_params
			params.permit(:password, :password_confirmation)
		end

end

