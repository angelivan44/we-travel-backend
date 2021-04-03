class AddCommentCountToComment < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :comments_count, :integer
    add_column :comments, :likes_count, :integer
  end
end
