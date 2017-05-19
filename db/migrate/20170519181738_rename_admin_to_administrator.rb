class RenameAdminToAdministrator < ActiveRecord::Migration[5.1]
  def change
    rename_table :admins, :administrators
  end
end
