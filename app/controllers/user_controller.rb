class UserController < ApplicationController
	skip_before_action :identify, only: [:create, :show]
	before_action :judge!, only: [:create]
	def create
		@user = User.new(params_user)
		render json: {code: 0, msg: "注册成功。"} if @user.save!
	rescue
    render json: {code: 3001, msg: "该用户名已存在"}
	end

	def show
    @user = User.select(:id, :nickname, :sex, :introduction, :avatar).where(id: params[:id]).take
    user = @user.as_json()
    user["url"] = user.delete("avatar")["url"]
		render json: {code: 0, user: user}
  rescue
		render json: {code: 3001, msg: "无法找到该用户"}
	end

	def update
    @user = User.find(session[:user_id])
		render json: {code: 0, msg: "更改个人信息成功", nickname: @user.nickname, sex: @user.sex, introduction: @user.introduction} if @user && @user.update!(params_user_need) && session[:user_updated_at] = @user.updated_at
	rescue 
		render json: {code: 3001, msg: "更改个人信息失败"}
	end

	def update_head_image
    @user = User.find(session[:user_id])
		render json: {code: 0, msg: "更改个人头像成功", url: @user.avatar.url} if @user && @user.update!(avatar_params) && session[:user_updated_at] = @user.updated_at
	 rescue
	 	render json: {code: 3001, msg: "更改个人头像失败,只允许Jpg,Jpeg,Gif,Png格式的图片"}
	end

	def update_password
		@user = User.find(session[:user_id])
		render json: {code: 0, msg: "更改密码成功"} if @user.update!(password_params) && session[:user_updated_at] = @user.updated_at
	rescue 
		render json: {code: 3001, msg: @user.errors.full_messages}
	end

	def show_oneself
		render json: {code: 0, user: current_user}
	end

	private
    
  def judge!
    if params_user[:password].nil? || params_user[:password] != params_user[:password_confirmation] || params_user[:password].length < 6
      render json: {code: 3001, msg: "您所填写的信息有误"}
    end
  end
    
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

