class DropReferenseProjectUsersId < ActiveRecord::Migration[7.0]
  def change
    remove_reference :projects, :users, index: true
  end
end
