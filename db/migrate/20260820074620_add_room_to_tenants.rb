class AddRoomToTenants < ActiveRecord::Migration[8.0]
  def change
    add_reference :tenants, :room, null: false, foreign_key: true
  end
end
