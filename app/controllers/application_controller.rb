class ApplicationController < ActionController::Base
  include ActionController::Live
  # protect_from_forgery with: :exception
  before_action :identify

  helper_method :current_user

  def current_user
      if user = $cache.get("User/#{session[:user_id]}")
        user
      else
        @user = @user = User.select(:id, :nickname, :sex, :introduction, :avatar).find_by_id(params[:id])
        user = @user.as_json()
        user["url"] = user.delete("avatar")["url"]
        user
      end
    rescue
      false
  end

  protected
  	def identify
  		render json: {code: 3001, msg: "请先登录"} unless session[:user_id]
  	end

end
