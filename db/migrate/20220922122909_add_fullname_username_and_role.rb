class AddFullnameUsernameAndRole < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :full_name, :string, null: false
    add_column :users, :username, :string, null: false
    add_column :users, :role, :string, null: false
    add_index :users, :username, unique: true

  end
end
