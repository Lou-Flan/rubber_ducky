class CreateListingsExperiences < ActiveRecord::Migration[5.2]
  def change
    create_table :listings_experiences do |t|
      t.references :listing
      t.references :experience

      t.timestamps
    end
  end
end
