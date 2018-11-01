class AddBillingAndShippingToAddresses < ActiveRecord::Migration[5.1]
  def change
    add_column :addresses, :billing, :boolean, default: false
    add_column :addresses, :shipping, :boolean, default: false
  end
end
