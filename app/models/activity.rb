class Activity < ActiveRecord::Base
	has_many :activity_applies
	has_many :likes
	belongs_to :user
	belongs_to :group
  
  
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