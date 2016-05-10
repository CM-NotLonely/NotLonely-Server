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

	validates :username, uniqueness: {is: true, on: :create}
	validates :username, length: { minimum: 6 }
	validates :password, length: { minimum: 6 }, confirmation: true, if: :status? 
	validates :password_confirmation, presence: true, if: :status? 
	after_update :write_cache
	after_find do |u|
		u.write_cache unless $cache.get("User/#{u.id}/#{u.updated_at.to_i}")
	end

		def status?
			status.blank?
		end

		def self.authenticate(params_user)
			find_by_username(params_user[:username]).try(:authenticate, params_user[:password])
		end

		def cache_key
			"User/#{self.id}//#{self.updated_at.to_i}"
		end

		def write_cache
      params = self.as_json(except: [:id, :username, :password_digest, :created_at, :updated_at])
      params["url"] = params.delete("avatar")["url"]
			$cache.set(cache_key, params)
		end
end