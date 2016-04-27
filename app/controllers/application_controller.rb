class ApplicationController < ActionController::Base
  include ActionController::Live
  # protect_from_forgery with: :exception
  before_action :identify

  helper_method :current_user

  def current_user
      ($cache.get("User/#{session[:user_id]}") || User.find(session[:user_id])).as_json(except: [:id, :username, :password_digest, :created_at, :updated_at])
    rescue
      false
  end

  protected
  	def identify
  		render json: {code: 3001, msg: "请先登录"} unless session[:user_id]
  	end

end
