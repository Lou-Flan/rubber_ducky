class Listing < ApplicationRecord
    has_one_attached :picture
    belongs_to :user

    has_many :favorite_listings  
    has_many :favorited_by, through: :favorite_listings, source: :user

    def button
        if current_user.id == @listing.user.id
            @show_button = true
        elsif current_user.id == nil
            @show_button = false
        else
            
        end 
    end

end
