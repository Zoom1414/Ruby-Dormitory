class AddPenaltyDaysToInvoices < ActiveRecord::Migration[8.0]
  def change
    add_column :invoices, :penalty_days, :integer
  end
end