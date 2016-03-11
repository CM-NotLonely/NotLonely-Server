class Activity < ActiveRecord::Base
	has_many :activity_applies
	has_many :likes
	belongs_to :user
	belongs_to :group
end