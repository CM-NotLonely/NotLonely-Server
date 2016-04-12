class User < ActiveRecord::Base
	has_secure_password
	attr_accessor :status

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

	validates :username, uniqueness: {is: true, message: "用户已存在", on: :create}
	validates :username, length: { minimum: 8 , message: "用户名最小长度为8"}
	validates :password, length: { minimum: 8 , message: "密码最小长度为8"}, confirmation: true, if: :status? 
	validates :password_confirmation, presence: true, if: :status? 
	before_destroy :cache_delete
	before_update :cache_delete
	before_save :cache_delete
	after_update :write_cache
	after_find do |u|
		u.write_cache unless $cache.get("User/#{u.id}")
	end

		def status?
			status.blank?
		end

		def self.authenticate(params_user)
			@user = find_by_username(params_user[:username]).try(:authenticate, params_user[:password])
		end

		def cache_key
			"User/#{self.id}"
		end

		def write_cache
			$cache.set(cache_key,self)
		end

		def cache_delete
			$cache.delete(cache_key)
		end
end