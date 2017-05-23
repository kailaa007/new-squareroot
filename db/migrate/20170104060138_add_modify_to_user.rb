class AddModifyToUser < ActiveRecord::Migration
  def change
  	remove_column :users, :age
  	add_column :users, :terms_n_condition, :boolean
  end
end
