class AddPurchasedToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :purchased, :boolean, default: false
  end
end
