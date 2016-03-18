class Like < ActiveRecord::Base
	belongs_to :user
	belongs_to :activity
	validates_uniqueness_of :user_id, scope: :activity_id#这一行是莫声龙加的，用来避免重复点赞
end