class ActivityApply < ActiveRecord::Base
	belongs_to :user
	belongs_to :activity
  
  def exp(*params)
    self.as_json(except: params)
  end
end