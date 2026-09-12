class AddMovedOutAtToTenants < ActiveRecord::Migration[8.0]
  def change
    add_column :tenants, :moved_out_at, :datetime
  end
end