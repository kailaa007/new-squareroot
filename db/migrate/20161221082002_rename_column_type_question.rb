class RenameColumnTypeQuestion < ActiveRecord::Migration
  def change
  	rename_column :questions, :type, :ques_type
  end
end
