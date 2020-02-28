class FavoriteListing < ApplicationRecord
  belongs_to :listing
  belongs_to :user

  validates_uniqueness_of :user, scope: :listing, message: "Already favourited"
end
