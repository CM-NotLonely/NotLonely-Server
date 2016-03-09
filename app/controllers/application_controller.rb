class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  #增加控制器的过滤器，只有当建立session后，才允许执行敏感动作。
  before_action :identify

  protected
  	def identify
  		unless session[:user_id] != nil 
  			render json: {code: 3001}
  		end
  	end

    # def update_object(j,k)
    #   for i in 0..j.size
    #     j[i] = k[i]
    #   end
    #   return j
    # end
end
