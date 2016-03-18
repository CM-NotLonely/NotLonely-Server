#msl
class DestroyLikesCountToActivity < ActiveRecord::Migration
  def change
  	remove_column :activities, :likes_count
  end
end