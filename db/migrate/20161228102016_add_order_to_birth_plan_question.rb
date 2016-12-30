class AddOrderToBirthPlanQuestion < ActiveRecord::Migration
  def change
  	add_column :birth_plan_questions, :order, :integer
  end
end
