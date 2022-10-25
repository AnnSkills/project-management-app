class AddDeviseToAccount < ActiveRecord::Migration[7.0]
  def change
    ## Database authenticatable
    add_column :accounts, :email, :string, null: false, default: ""
  end
end
