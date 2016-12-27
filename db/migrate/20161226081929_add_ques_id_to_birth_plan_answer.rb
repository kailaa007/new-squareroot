class AddQuesIdToBirthPlanAnswer < ActiveRecord::Migration
  def change
    add_column :birth_plan_answers, :question_id, :integer
  end
end
