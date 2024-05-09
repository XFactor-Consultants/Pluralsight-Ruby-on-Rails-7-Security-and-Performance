class IncreaseTokenLength < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :reset_password_token, :string, limit: 128
    change_column :users, :confirmation_token, :string, limit: 128
  end
end
