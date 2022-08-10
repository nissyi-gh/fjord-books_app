class AddNotNullToReports < ActiveRecord::Migration[6.1]
  def change
    change_column_null :reports, :title, false
    change_column_null :reports, :body, false
    change_column_null :reports, :user_id, false
  end
end
