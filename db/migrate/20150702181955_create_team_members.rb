class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.string :name
      t.string :title
      t.text :bio
      t.integer :position, default: 0

      t.timestamps null: false
    end
  end
end
