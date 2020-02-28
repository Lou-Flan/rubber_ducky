class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy, :favorite]
    before_action :authenticate_user!, only: [:edit, :update, :destroy, :show]
    before_action :set_user_listing, only: [:edit, :update, :destroy]
    # before_action :logged_in, only: [:index]

    def index
        @listings = Listing.all
    end

    def show
        if current_user.id == @listing.user.id
            @show_button = true
        elsif current_user.id == nil
            @show_button = false
        end
    end

    def new
        @listing = Listing.new
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

      # Add and remove favorite recipes
  # for current_user
  def favorite
    type = params[:type]
    if type == "favorite"
      current_user.favorites << @listing
    #   redirect_to :back, notice: 'You favorited #{@listing.name}'

    elsif type == "unfavorite"
      current_user.favorites.delete(@listing)
    #   redirect_to :back, notice: 'Unfavorited #{@listing.name}'

    else
      # Type missing, nothing happens
      redirect_to :back, notice: 'Nothing happened.'
    end
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

    def listing_params
        params.require(:listing).permit(:name, :description, :price, :picture)
    end

end