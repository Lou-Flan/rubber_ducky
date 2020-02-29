class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy, :favorite]
    before_action :authenticate_user!, only: [:edit, :update, :destroy, :show]
    before_action :set_user_listing, only: [:edit, :update, :destroy]
    before_action :experience
    # before_action :set_experience, only: [:edit, :update]
    # before_action :logged_in, only: [:index]

    def index
        @listings = Listing.all
    end

    def show
        console
    end

    def new
        @listing = Listing.new
        @listing.listings_experience.build
        # @experience = Experience.all 
    end

    def create
        @listing = current_user.listings.create(listing_params)

        if @listing.errors.any?
            render "new"
        else
            redirect_to listings_path
        end
    end

    def edit
        console
    end

    def update
        if @listing.update(listing_params)
            redirect_to @listing
        else
            render 'edit'
        end
    end

    def destroy
        @listing.destroy
 
        redirect_to listings_path
    end

# Add and remove favorite listings
  # for current_user
  def favorite
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @listing
      redirect_to listing_path, notice: 'You favorited #{@listing.name}'

    elsif type == "unfavorite"
      current_user.favorites.delete(@listing)
      redirect_to listing_path, notice: 'Unfavorited #{@listing.name}'

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
  end

#   def add_experience
#     @listing.listings_experience << experience.id
#     end

  def show_favorites
  end

  def manage_listings
  end

    private

    def set_listing
        id = params[:id]
        @listing = Listing.find(id)
    end

    def set_user_listing
        id = params[:id]
        @listing = current_user.listings.find_by_id(id)
    
        if @listing == nil
            redirect_to listings_path
        end
    end

    def experience
        @experience = Experience.all
    end

    # def set_experience

    #     @listing.listings_experience.create(params[:experience_id])
    # end

    def listing_params
        params.require(:listing).permit(:name, :description, :price, :picture, experience_ids: [])
    end

end