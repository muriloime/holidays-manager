class AddNullToManager < ActiveRecord::Migration
  def change
    change_column :users, :manager, :boolean, :default => false, :null => false
  end
end
