class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :title
      t.text :excerpt
      t.text :link
      t.references :tag, index: true, foreign_key: true
      t.integer :visits, default: 0

      t.timestamps null: false
    end
  end
end
