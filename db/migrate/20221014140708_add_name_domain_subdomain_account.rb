class AddNameDomainSubdomainAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :accounts, :name, :string
    add_column :accounts, :domain, :string
    add_column :accounts, :subdomain, :string
  end
end
