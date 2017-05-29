class AddAuthTokenToAdministrator < ActiveRecord::Migration
  def change
  	add_column :administrators, :auth_token, :string
  end
end
