class PopulateSummaryOnOldPosts < ActiveRecord::Migration
  def up
    Post.all.each { |p| p.save }
  end

  def down
    # NOOP
  end
end
