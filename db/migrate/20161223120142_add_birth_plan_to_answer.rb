class AddBirthPlanToAnswer < ActiveRecord::Migration
  def change
  	add_column :birth_plan_answers, :birth_plan_id, :integer
  end
end
