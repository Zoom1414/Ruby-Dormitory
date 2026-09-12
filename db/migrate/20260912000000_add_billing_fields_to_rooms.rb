class AddBillingFieldsToRooms < ActiveRecord::Migration[8.0]
  def change
    add_column :rooms, :electricity_meter_previous, :integer, null: false, default: 0
    add_column :rooms, :electricity_meter_current, :integer, null: false, default: 0
    add_column :rooms, :electricity_rate, :decimal, precision: 8, scale: 2, null: false, default: 8.0
  end
end