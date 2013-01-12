class DevisifyUsers < ActiveRecord::Migration
  def up
    # Remove restful auth columns
    remove_column :users, :login
    remove_column :users, :crypted_password
    remove_column :users, :salt
    remove_column :users, :remember_token
    remove_column :users, :remember_token_expires_at
    # Add devise columns
    add_column :users, :encrypted_password, :string, :null => false, :default => ""
    add_column :users, :remember_created_at, :datetime
  end

  def down
    # Add devise columns
    remove_column :users, :remember_created_at
    remove_column :users, :encrypted_password

    # Add restful auth columns
    add_column :users, :remember_token_expires_at, :datetime
    add_column :users, :remember_token, :string, :limit => 40
    add_column :users, :salt, :string, :limit => 40
    add_column :users, :crypted_password, :string, :limit => 40
    add_column :users, :login, :string, :limit => 40, :null => false
  end
end