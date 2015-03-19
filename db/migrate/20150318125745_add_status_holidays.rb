class AddStatusHolidays < ActiveRecord::Migration
  def change
    add_column :holidays, :status, :string
  end
end
