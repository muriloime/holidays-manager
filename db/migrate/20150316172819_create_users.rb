class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password
      t.string :name
      t.string :

      t.timestamps null: false
    end
  end
end
