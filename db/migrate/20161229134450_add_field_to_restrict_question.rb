class AddFieldToRestrictQuestion < ActiveRecord::Migration
  def change
  	add_column :restrict_questions, :base_option_id, :integer
  	add_column :restrict_questions, :main_option_id, :integer
  	add_column :restrict_questions, :option_status, :boolean
  	rename_column :restrict_questions, :status, :ques_status
  end
end
