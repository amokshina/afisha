class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.string :event_type
      t.string :place
      t.integer :num_of_people
      t.text :description
      t.datetime :event_date  # Используйте t.datetime для поля типа timestamp

      t.timestamps
    end
  end
end
