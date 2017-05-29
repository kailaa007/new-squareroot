class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :option_title
      t.integer :question
      t.timestamps null: false
    end
  end
end
