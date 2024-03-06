class AddImageToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :image, :json
  end
end
