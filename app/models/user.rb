class User < ActiveRecord::Base
	has_many :groups
	has_many :activities
	has_many :activity_applies
	has_many :group_applies
	has_many :group_invites
	has_many :likes
	has_many :user_follows, :class_name => 'Follow', :foreign_key => 'user_follow_id'
	has_many :user_followeds, :class_name => 'Follow', :foreign_key => 'user_followed_id'
	has_many :group_inviteds, :class_name => 'Group', :foreign_key => 'group_invited_id'
	mount_uploader :avatar, AvatarUploader
	#设置用户表中的数据要求。
	validates :username, uniqueness: true, length: { in: 5..10 }
	validates :password, length: { minimum: 6 }

	# # 增加缓存，过期时间为10minitues。
	# def cache_key
	# 	@user = User.select(:id, :updated_at).where(id: session[:user_id]).try(:utc).try(:to_s, :number)
	# 	cache_key = "Users/#{@user}"
	# end
	# def get_cache
	# 	rails.cache.fetch("#{cache_key}", expires_in: 10.minitues) do
	# 		Application::API.find_by(id: session[:user_id])
	# 	end
	# end

	# after_update :cache_key, :write_key


	# 	def cache_key
	# 		cache_key = "#{write_key_real}"
	# 	end

	# 	def write_key_real
	# 		User.select(:id, :updated_at).where(id: session[:user_id]).try(:utc).try(:to_s, :number)
	# 	end
	# 	def write_value
	# 		User.find_by(id: session[:user_id])
	# 	end

	# 	def write_key
	# 		Rails.cache.write("#{cache_key}","#{write_value}")
	# 	end

	# 	def get_cache
	# 		Rails.cache.read(cache_key)
	# 	end
	# def cache_key
 #      cache_key = "#{write_key_real}"
 #    end

 #    def write_key_real
 #      User.select(:id, :updated_at).where(id: session[:user_id]).try(:utc).try(:to_s, :number)
 #    end
 #    def write_value
 #      User.find_by(id: session[:user_id])
 #    end

 #    def write_key
 #      Rails.cache.write(cache_key,write_value)
 #    end

    # def get_cache
    #   Rails.cache.read(User.cache_key)
    # end
end