class RemovePenaltyFieldsFromInvoices < ActiveRecord::Migration[8.0]
  def change
    remove_column :invoices, :penalty_rate, :decimal
    remove_column :invoices, :penalty_days, :integer
  end
end
