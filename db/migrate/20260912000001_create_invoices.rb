class CreateInvoices < ActiveRecord::Migration[8.0]
  def change
    create_table :invoices do |t|
      t.references :room, null: false, foreign_key: true
      t.date :billing_month, null: false
      t.date :due_date, null: false
      t.decimal :base_amount, precision: 10, scale: 2, null: false, default: 0
      t.decimal :penalty_rate, precision: 10, scale: 2, null: false, default: 100
      t.datetime :paid_at
      t.timestamps
    end

    add_index :invoices, %i[room_id billing_month], unique: true
  end
end