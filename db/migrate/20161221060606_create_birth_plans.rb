class CreateBirthPlans < ActiveRecord::Migration
  def change
    create_table :birth_plans do |t|
      t.string :title
      t.boolean :status
      t.text :description

      t.timestamps null: false
    end
  end
end
