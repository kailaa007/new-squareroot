class AddRequiredToQuestion < ActiveRecord::Migration
  def change
  	add_column :questions, :required, :boolean
  end
end
