class UserController < ApplicationController
	skip_before_action :identify, only: [:create, :show]
	
	def create
		@user = User.new(params_user)
		render json: {code: 0, msg: "Successfully Sign Up => 注册成功。"} if @user.save!
	rescue
		 	render json: {code: 3001, msg: @user.errors.full_messages}
	end

	def show
		render json: {code: 0, user: @user} if @user = User.find(params[:id]).as_json(except: [:id, :username, :password_digest, :created_at, :updated_at])
	rescue
		render json: {code: 3001, msg: "This user can't be found => 无法找到该用户"}
	end

	def update
		render json: {code: 0, msg: "Successfully Update Personal Information => 更改个人信息成功"} if User.find(session[:user_id]).update!(params_user_need) #.as_json(except: [:id, :created_at, :updated_at, :username, :password_digest])
	rescue
		render json: {code: 3001, msg: "Update Personal Information Faily => 更改个人信息失败"}
	end

	def update_head_image
		render json: {code: 0, msg: "Successfully Update HeadImage => 更改个人头像成功"} if User.find(session[:user_id]).update!(avatar_params)
	rescue
		render json: {code: 3001, msg: "Update HeadImage Faily => 更改个人头像失败"}
	end

	def update_password
		render json: {code: 0, msg: "Successfully Update Password => 更改密码成功"} if User.find(session[:user_id]).update!(password_params)
	rescue
		render json: {code: 3001, msg: "Update Password Faily => 更改密码失败"}
	end

	def show_oneself
		render json: {code: 0, user: current_user}
	end

	private
		def params_user
			params.permit(:username, :password, :password_confirmation, :nickname, :sex, :introduction, :avatar, :status)
		end

		def params_user_need
			params.permit(:nickname, :sex, :introduction, :status)
		end

		def avatar_params
			params.permit(:avatar, :status)
		end

		def password_params
			params.permit(:password, :password_confirmation, :status)
		end

end

