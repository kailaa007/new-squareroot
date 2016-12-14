class AddDateToNews < ActiveRecord::Migration
  def change
    add_column :news, :post_date, :date
  end
end
