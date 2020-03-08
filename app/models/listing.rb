class Listing < ApplicationRecord
    validates_presence_of :name, :description, :price
    validates :name, format: { with: /^[a-zA-Z0-9]*$/, :multiline => true, message: "should only contain alpha-numeric characters" }
    validates :price, numericality: { only_integer: true }
    validates :description, length: { maximum: 1000, too_long: "1000 character limit, please shorten your description"}

    has_one_attached :picture
    belongs_to :user

    has_many :favorite_listings, dependent: :destroy
    has_many :favorited_by, through: :favorite_listings, source: :user

    has_many :listings_experience, dependent: :destroy
    has_many :experiences, through: :listings_experience

    before_validation :sanitize_listing_inputs, on: [:new, :create, :update, :edit]

#-----------------------------------------------------------------------
# works with the delete & edit methods in application_helper. 
# the current user is parsed in, the method checks if the current user id
# matches the current listing user then returns a boolean value which
# determines whether to show the edit/delete buttons
#-----------------------------------------------------------------------
    def editable_by?(user)
        user && (user == self.user)
    end

    def deletable_by?(user)
        user && (user == self.user)
    end

    private

#-----------------------------------------------------------------------
# method is used before validation to only allow specified characters 
# within user input. the method removes any illegal characters before 
# the data is saved to the database. the sanitize ruby helper is also 
# used in the listing views.
#-----------------------------------------------------------------------  
    def sanitize_listing_inputs
        self.name = name.downcase
        (self.name && self.description).gsub!(/[^0-9A-Za-z ,.'"]/, '')
    end

end
