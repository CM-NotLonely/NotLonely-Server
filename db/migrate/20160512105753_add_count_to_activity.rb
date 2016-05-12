class AddCountToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :count, :integer
  end
end
