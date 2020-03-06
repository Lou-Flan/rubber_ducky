class AddStripeidAndReceiptToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :striperef, :string
    add_column :orders, :receipt, :string
  end
end
