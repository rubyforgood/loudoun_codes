class AddUsernameIndexToAccount < ActiveRecord::Migration[5.1]
  def change
    add_index :accounts, :username, unique: true
    add_index :accounts, [:username, :password]
  end
end
