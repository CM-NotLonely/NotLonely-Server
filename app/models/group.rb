class Group < ActiveRecord::Base
	belongs_to :user
	has_many :activities, dependent: :destroy
	has_many :group_applies
	has_many :group_invites
	mount_uploader :avatar, AvatarUploader
  
  #将数据转化为json并剔除传入参数params
  def exp(*params)
    self.as_json(except: params)
  end
  
  def self.selected!(*except_attributes)
    attributes = self.new.attributes.keys
    except_attributes.each do |at|
      attributes.delete at
    end
    self.select(attributes)
  end
end

