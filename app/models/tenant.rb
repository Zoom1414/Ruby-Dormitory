class Tenant < ApplicationRecord
  belongs_to :room

  scope :active, -> { where(moved_out_at: nil) }

  after_save :sync_room_status
  after_destroy :release_room_if_empty

  private

  def sync_room_status
    if saved_change_to_room_id?
      previous_room = Room.find_by(id: saved_change_to_room_id.first)
      previous_room&.update(status: "ว่าง") if previous_room && !previous_room.tenants.exists?
    end

    if moved_out_at.nil?
      room.update(status: "มีผู้พัก")
    else
      room.update(status: "ว่าง") unless room.tenants.active.exists?
    end
  end

  def release_room_if_empty
    room.update(status: "ว่าง") unless room.tenants.active.exists?
  end
end
