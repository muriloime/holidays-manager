class AddEmailsConfigToUsers < ActiveRecord::Migration
  def change
    add_column :users, :emails_receiver, :boolean, :default => true, :null => true
  end
end
