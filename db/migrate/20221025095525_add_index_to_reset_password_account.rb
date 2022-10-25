class AddIndexToResetPasswordAccount < ActiveRecord::Migration[7.0]
  def change
    add_index :accounts, :reset_password_token, unique: true
  end
end
