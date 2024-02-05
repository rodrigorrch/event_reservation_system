class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :event_type
      t.integer :number_of_people
      t.text :special_requests

      t.timestamps
    end
  end
end
