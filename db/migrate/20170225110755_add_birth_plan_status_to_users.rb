class AddBirthPlanStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :birth_plan_status, :boolean
  end
end
