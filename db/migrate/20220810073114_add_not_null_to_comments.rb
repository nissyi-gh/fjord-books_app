class AddNotNullToComments < ActiveRecord::Migration[6.1]
  def change
    change_column_null :comments, :body, false
    change_column_null :comments, :user_id, false
    change_column_null :comments, :commentable_type, false
    change_column_null :comments, :commentable_id, false
  end
end
