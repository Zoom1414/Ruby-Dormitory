class RemoveDueDateFromInvoices < ActiveRecord::Migration[8.0]
  def change
    remove_column :invoices, :due_date, :date
  end
end