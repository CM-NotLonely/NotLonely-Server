class SessionController < ApplicationController
	skip_before_action :identify, only: [:create]

	def create
		if @user = User.authenticate(params_user)
			session[:user_id] = @user.id
			render json: {code: 0, msg: "Successfully Login => 登录成功", user: @user.as_json(except: [:id, :created_at, :updated_at, :password_digest, :username])}
		else 
			render json: {code: 3001, msg: "Username or password is invalid => 用户名或者密码错误"}
		end
	end
	
	def destroy
		session[:user_id] = nil
		render json: {code: 0, msg: "Successfuly Sign Out => 成功退出"}
	end

	private
		def params_user
			params.permit(:username, :password)
		end
end