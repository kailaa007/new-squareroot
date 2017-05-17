class CreateChecklists < ActiveRecord::Migration
  def change
    create_table :checklists do |t|
      t.string :title
      t.string :category
      t.string :sub_category
      
      t.timestamps null: false
    end
  end
end
