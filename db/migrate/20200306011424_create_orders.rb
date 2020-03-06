class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :buyer_id
      t.references :listing
      t.timestamps
    end
  end
end
