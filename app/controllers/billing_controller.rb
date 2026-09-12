class BillingController < ApplicationController
  def index
    @rooms = Room.includes(:tenants).ordered
    @occupied_rooms = @rooms.select { |room| room.tenants.active.any? }
    @billing_month = Date.current.beginning_of_month
    @invoices = @occupied_rooms.map { |room| current_invoice_for(room) }
    @total_billing = @invoices.sum(&:total_amount)
    @paid_count = @invoices.count(&:paid?)
  end

  def update
    @room = Room.find(params[:id])
    @billing_month = Date.current.beginning_of_month
    if @room.update(billing_params)
      invoice = current_invoice_for(@room)
      invoice.update!(base_amount: @room.total_charge) unless invoice.paid?
      redirect_to billing_path, notice: "อัปเดตมิเตอร์ห้อง #{@room.room_number} เรียบร้อยแล้ว"
    else
      redirect_to billing_path, alert: "ไม่สามารถบันทึกข้อมูลมิเตอร์ได้"
    end
  end

  def pay
    invoice = Invoice.find(params[:id])
    invoice.update!(paid_at: Time.current)
    redirect_to billing_path, notice: "บันทึกการชำระเงินห้อง #{invoice.room.room_number} แล้ว"
  end

  def history
    @invoices = Invoice.includes(:room).order(billing_month: :desc, created_at: :desc)
  end

  private

  def billing_params
    params.require(:room).permit(:electricity_meter_previous, :electricity_meter_current, :electricity_rate)
  end

  def current_invoice_for(room)
    invoice = room.invoices.find_by(billing_month: @billing_month)
    unless invoice
      rollover_electricity_meter(room)
      invoice = room.invoices.create!(billing_month: @billing_month, base_amount: room.total_charge)
    end

    invoice.update!(base_amount: room.total_charge) unless invoice.paid?
    invoice
  end

  def rollover_electricity_meter(room)
    previous_invoice = room.invoices.order(billing_month: :desc).first
    return unless previous_invoice && previous_invoice.billing_month < @billing_month

    room.update!(electricity_meter_previous: room.electricity_meter_current)
  end
end