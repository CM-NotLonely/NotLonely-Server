class Group < ActiveRecord::Base
	belongs_to :user
	has_many :activities, dependent: :destroy # edited by msl
	has_many :group_applies
	has_many :group_invites
	mount_uploader :avatar, AvatarUploader
end

