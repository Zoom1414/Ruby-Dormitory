require "test_helper"

class InvoiceTest < ActiveSupport::TestCase
  test "uses the room charge as the invoice total" do
    invoice = Invoice.new(room: rooms(:one), billing_month: Date.new(2026, 9, 1), base_amount: 5000)

    assert_equal 5000, invoice.total_amount
    assert_not invoice.paid?
  end

  test "records a paid invoice" do
    invoice = Invoice.create!(room: rooms(:one), billing_month: Date.new(2026, 9, 1), base_amount: 5000, paid_at: Time.zone.local(2026, 9, 3, 10, 0, 0))

    assert invoice.paid?
    assert_equal 5000, invoice.total_amount
  end
end
