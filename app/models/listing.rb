class Listing < ApplicationRecord
    has_one_attached :picture
    belongs_to :user

    has_many :favorite_listings  
    has_many :favorited_by, through: :favorite_listings, source: :user

    has_many :listings_experience
    has_many :experiences, through: :listings_experience

    def button
        if current_user.id != @listing.user.id
            @show_button = true
        elsif current_user.id == nil
            @show_button = false
        else
            
        end 
    end

    # method to use search bar, if no search params are present, all listings will be returned
    # the search will look for close matches in listing name or description
    def self.search(search)
        if search
            if search.present?
                self.where("name || description ILIKE ?", "%#{search}%")
            else
                @listings = Listing.all.order('id desc')
            end
        else
            @listings = Listing.all.order('id desc')
        end
    end

end
