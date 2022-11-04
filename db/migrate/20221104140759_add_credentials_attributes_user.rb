class AddCredentialsAttributesUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :access_code, :string
    add_column :users, :publishable_key, :string
    add_column :users, :stripe_id, :string
    add_column :users, :subscribed, :boolean
    add_column :users, :card_last4, :string
    add_column :users, :card_exp_month, :string
    add_column :users, :card_exp_year, :string
    add_column :users, :card_type, :string
  end
end
