class SessionController < ApplicationController
	skip_before_action :identify, only: [:create]

	def create
		if @user = User.authenticate(params_user) 
			session[:user_id] = @user.id
      session[:user_updated_at] = @user.updated_at.to_i
      user = @user.as_json(except: [:id, :created_at, :updated_at, :password_digest, :username])
      user[:url] = user.delete(:avatar).url
			render json: {code: 0, msg: "登录成功", user: user}
		else 
			render json: {code: 3001, msg: "用户名或者密码错误"}
		end
	end
	
	def destroy
		session[:user_id] = nil
		render json: {code: 0, msg: "成功退出"}
	end

	private
		def params_user
			params.permit(:username, :password)
		end
end