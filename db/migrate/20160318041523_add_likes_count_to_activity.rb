#msl
class AddLikesCountToActivity < ActiveRecord::Migration
  def change
  	add_column :activities, :likes_count, :integer, default: 0
  end
end