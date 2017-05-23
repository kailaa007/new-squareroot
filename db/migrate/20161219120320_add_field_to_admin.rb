class AddFieldToAdmin < ActiveRecord::Migration
  def change
  	add_column :administrators, :super_admin, :boolean
  end
end
