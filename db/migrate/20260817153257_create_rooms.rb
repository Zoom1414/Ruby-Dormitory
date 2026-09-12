class CreateRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :rooms do |t|
      t.string :room_number
      t.integer :floor
      t.string :room_type
      t.decimal :rent
      t.string :status

      t.timestamps
    end
  end
end
