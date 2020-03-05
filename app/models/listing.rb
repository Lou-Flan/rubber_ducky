class Listing < ApplicationRecord
    validates_presence_of :name, :description, :price
    validates :name, format: { with: /^[a-zA-Z0-9_\.]*$/, :multiline => true, message: "Only alpha-numeric characters and _" }
    validates :price, numericality: { only_integer: true }
    validates :description, length: { maximum: 1000, too_long: "1000 character limit, please shorten your description"}

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
    # BEFORE RANSACK IMPLEMENTED
    # def self.search(search)
    #         if search != "" && search != nil
    #             return self.where("name || description ILIKE ?", "%#{search}%")
    #         else
    #             return self.all.order('id desc')
    #         end
    # end

    def editable_by?(user)
        user && (user == self.user)
    end

    def deletable_by?(user)
        user && (user == self.user)
    end

    # def self.purchased?(listing)
    #     if self.find(listing).purchased == true
    #         @listing = true
    #     else
    #         @listing = self.find(listing)
    #     end
    # end


end
