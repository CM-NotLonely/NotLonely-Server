class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #增加控制器的过滤器，只有当建立session后，才允许执行敏感动作。
  before_action :identify

  helper_method :current_user

  def current_user
      ($cache.get("User/#{session[:user_id]}") || User.find(session[:user_id])).as_json(except: [:id, :username, :password_digest, :created_at, :updated_at])
    rescue
      false
  end

  protected
  	def identify
  		render json: {code: 3001, msg: "请先登录"} unless session[:user_id] #&& current_user
  	end

end
