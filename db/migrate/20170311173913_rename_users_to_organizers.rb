class RenameUsersToOrganizers < ActiveRecord::Migration[5.0]
  def change
    rename_table :users, :organizers
  end
end
