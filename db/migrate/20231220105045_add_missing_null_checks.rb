class AddMissingNullChecks < ActiveRecord::Migration[7.1]
  def change
    change_column_null :events, :title, false
    change_column_null :events, :event_type, false
    change_column_null :events, :event_date, false
    change_column_null :events, :place, false
    change_column_null :events, :description, false
    change_column_null :events, :num_of_people, false

    change_column_null :comments, :body, false
  end
end
