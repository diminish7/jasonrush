class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title, :allow_nil => false
      t.text :body, :allow_nil => false
      t.string :author_id, :allow_nil => false
      t.integer :blog_id
      t.string :cached_slug
      t.timestamps
    end
    
    add_index :posts, :title
    add_index :posts, :blog_id
    add_index :posts, :created_at
  end

  def self.down
    drop_table :posts
  end
end
