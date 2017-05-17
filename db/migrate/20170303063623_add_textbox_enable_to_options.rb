class AddTextboxEnableToOptions < ActiveRecord::Migration
  def change
    add_column :options, :textbox_enable, :boolean, default: false
    add_column :options, :description, :string
  end
end
