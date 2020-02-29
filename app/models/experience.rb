class Experience < ApplicationRecord
    has_many :listings_experience
    has_many :listings, through: :listings_experience
end
