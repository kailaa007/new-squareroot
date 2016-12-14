class AddSubtitleToTeamMembers < ActiveRecord::Migration
  def change
    add_column :team_members, :subtitle, :string
  end
end
