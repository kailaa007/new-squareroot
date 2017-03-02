class AddChecklistOnToBirthPlan < ActiveRecord::Migration
  def change
    add_column :birth_plans, :checklist_on, :string
  end
end
