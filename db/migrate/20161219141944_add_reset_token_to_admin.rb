class AddResetTokenToAdmin < ActiveRecord::Migration
  def change
  	add_column :administrators, :reset_token, :string
  	add_column :administrators, :resent_sent_at, :datetime
  end
end
