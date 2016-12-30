class AddSlugToBirthPlan < ActiveRecord::Migration
  def change
  	add_column :birth_plans, :slug, :string
    add_index :birth_plans, :slug, unique: true
  end
end
