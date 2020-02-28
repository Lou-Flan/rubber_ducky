class CreateFavoriteListings < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_listings do |t|
      t.references :listing, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
