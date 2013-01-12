class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :email
      t.string :name
      t.text :comment
      t.integer :commentable_id
      t.string :commentable_type
      t.boolean :active, :default => true
      t.timestamps
    end
    
    add_index :comments, :email
    add_index :comments, [:commentable_id, :commentable_type]
    add_index :comments, :created_at
  end

  def self.down
    drop_table :comments
  end
end
