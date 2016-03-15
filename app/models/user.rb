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

	# 增添回调，当更新用户时生成cache，登录后，生成cache，退出后删除cache。
	before_destroy :cache_delete

	after_update :write_cache, :cache_key

		def cache_key
			"User/#{self.id}/#{self.updated_at.to_i}"
		end

		def write_cache
			Rails.cache.fetch(:cache_key) do
				self
			end
		end

		def self.read_cache
			Rails.cache.fetch(:cache_key)
		end

		def cache_delete
			Rails.cache.delete(:cache_key)
		end
end