class Room < ApplicationRecord
  WATER_RATE = 100

  has_many :tenants
  has_many :invoices, dependent: :destroy

  scope :ordered, -> { order(Arel.sql("CAST(room_number AS INTEGER) ASC"), :room_number) }

  def electricity_units
    [electricity_meter_current.to_i - electricity_meter_previous.to_i, 0].max
  end

  def water_charge
    tenants.active.count * WATER_RATE
  end

  def electricity_charge
    electricity_units * electricity_rate.to_d
  end

  def total_charge
    rent.to_d + water_charge + electricity_charge
  end
end
