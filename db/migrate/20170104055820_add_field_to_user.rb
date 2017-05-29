class AddFieldToUser < ActiveRecord::Migration
  def change
  	add_column :users, :zipcode, :integer
  	add_column :users, :due_date, :date
  end
end
