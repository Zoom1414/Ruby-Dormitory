require "test_helper"

class TenantTest < ActiveSupport::TestCase
  test "marks the room as occupied when a tenant is added" do
    room = rooms(:one)
    room.update!(status: "ว่าง")

    Tenant.create!(name: "ผู้พักทดสอบ", phone: "0800000000", id_card: "1234567890123", room: room)

    assert_equal "มีผู้พัก", room.reload.status
  end

  test "marks the old room as available when a tenant moves" do
    old_room = rooms(:one)
    new_room = rooms(:two)
    old_room.update!(status: "มีผู้พัก")
    new_room.update!(status: "ว่าง")
    tenant = Tenant.create!(name: "ผู้พักทดสอบ", phone: "0800000000", id_card: "1234567890123", room: old_room)

    tenant.update!(room: new_room)

    assert_equal "ว่าง", old_room.reload.status
    assert_equal "มีผู้พัก", new_room.reload.status
  end

  test "marks the room as available when its last tenant leaves" do
    room = rooms(:one)
    tenant = Tenant.create!(name: "ผู้พักทดสอบ", phone: "0800000000", id_card: "1234567890123", room: room)

    tenant.destroy!

    assert_equal "ว่าง", room.reload.status
  end

  test "keeps move-out history and frees the room" do
    room = rooms(:one)
    tenant = Tenant.create!(name: "ผู้พักทดสอบ", phone: "0800000000", id_card: "1234567890123", room: room)

    tenant.update!(moved_out_at: Time.current)

    assert_not tenant.reload.moved_out_at.nil?
    assert_not Tenant.active.exists?(tenant.id)
    assert_equal "ว่าง", room.reload.status
  end
end
