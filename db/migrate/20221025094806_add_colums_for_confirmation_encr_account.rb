class AddColumsForConfirmationEncrAccount < ActiveRecord::Migration[7.0]
  def change
    ## Database authenticatable
    add_column :accounts, :encrypted_password, :string
    ## Recoverable
    add_column :accounts, :reset_password_token, :string
    add_column :accounts, :reset_password_sent_at, :datetime
    ## Rememberable
    add_column :accounts, :remember_created_at, :datetime
    ## Confirmable
    add_column :accounts, :confirmation_token, :string
    add_column :accounts, :confirmed_at, :datetime
    add_column :accounts, :confirmation_sent_at, :datetime
    add_column :accounts, :unconfirmed_email, :string
  end
end

