class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.text :content
      t.references :user, index: true
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end
    add_foreign_key :holidays, :users
    add_index :holidays, [:user_id, :created_at]
  end
end
