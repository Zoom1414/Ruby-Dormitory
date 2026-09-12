require "test_helper"

class RoomTest < ActiveSupport::TestCase
  test "calculates rent water and electricity charges" do
    room = rooms(:one)
    room.update!(rent: 4000, electricity_meter_previous: 120, electricity_meter_current: 145, electricity_rate: 8)
    Tenant.create!(name: "ผู้พักทดสอบ", phone: "0800000000", id_card: "1234567890123", room: room)
    Tenant.create!(name: "ผู้พักอีกคน", phone: "0800000001", id_card: "1234567890124", room: room)

    assert_equal 200, room.water_charge
    assert_equal 200, room.electricity_charge
    assert_equal 4400, room.total_charge
  end

  test "does not charge negative electricity usage" do
    room = rooms(:one)
    room.update!(electricity_meter_previous: 200, electricity_meter_current: 150, electricity_rate: 8)

    assert_equal 0, room.electricity_units
    assert_equal 0, room.electricity_charge
  end
end
