class CreationOfAccountSubscriptionPlans < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :plan, :string
    add_column :accounts, :subscription_id, :string
  end
end
