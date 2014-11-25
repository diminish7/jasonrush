class ChangeAuthorIdFromStringToInteger < ActiveRecord::Migration
  def up
    change_column :posts, :author_id, :integer
  end

  def down
    change_column :posts, :author_id, :string
  end
end
