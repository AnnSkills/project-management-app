class AcceptNullUserIdForAccounts < ActiveRecord::Migration[7.0]
  def change
    change_column_null(:accounts, :user_id, true)
  end
end
