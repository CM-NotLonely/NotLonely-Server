class SessionController < ApplicationController
	#建立session的动作跳过过滤器，但是删除session的动作不跳过，防止用户session被恶意删除。
	skip_before_action :identify, only: [:create]
	#用户登录验证，验证通过后建立session。
	def create
		@user = User.find_by(params_user)
		if @user
			@user.cache_key
			@user.write_cache
			session[:user_id] = @user.id
			render json: {code: 0, msg: "登录成功", user: @user}
		else
			render json: {code: 3001, msg: "用户名或者密码错误"}
		end
	end
	
	#用户请求退出，触发后删除session。
	def destroy
		@user = User.find_by(id: session[:user_id])
		@user.cache_delete
		session[:user_id] = nil
		render json: {code: 0, msg: "成功退出"}
	end
	#设置参数白名单。
	private
		def params_user
			params.permit(:username, :password)
		end
end