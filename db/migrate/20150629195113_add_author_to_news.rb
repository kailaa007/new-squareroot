class AddAuthorToNews < ActiveRecord::Migration
  def change
    add_column :news, :author, :string
  end
end
