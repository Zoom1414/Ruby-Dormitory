class Invoice < ApplicationRecord
  belongs_to :room

  validates :billing_month, :base_amount, presence: true

  def paid?
    paid_at.present?
  end

  def total_amount
    base_amount.to_d
  end
end