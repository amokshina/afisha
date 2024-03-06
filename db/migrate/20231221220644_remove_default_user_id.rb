class RemoveDefaultUserId < ActiveRecord::Migration[7.1]
  def change
    change_column_default :events, :user_id, from: 1, to: nil
  end
end
