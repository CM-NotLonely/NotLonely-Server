class User < ActiveRecord::Base
	has_many :groups
	has_many :activities
	has_many :activity_applies
	has_many :group_applies
	has_many :group_invites
	has_many :likes
	has_many :user_follows, :class_name => 'Follow', :foreign_key => 'user_follow_id'
	has_many :user_followeds, :class_name => 'Follow', :foreign_key => 'user_followed_id'
	has_many :group_invites, :class_name => 'Group', :foreign_key => 'group_invite_id'
	has_many :group_inviteds, :class_name => 'Group', :foreign_key => 'group_invited_id'
	mount_uploader :avatar, AvatarUploader
end
