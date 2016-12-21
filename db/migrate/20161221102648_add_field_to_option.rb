class AddFieldToOption < ActiveRecord::Migration
  def change
  	remove_column :options, :question
  	add_reference :options, :question, index: true
  end
end
