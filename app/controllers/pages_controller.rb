class PagesController < ApplicationController
#-----------------------------------------------------------------------
# checks the listings database for rows with the value false in the 
# purchased column, then returns the five most recent entries
#-----------------------------------------------------------------------
  def home
   @listings = Listing.where(purchased: :false).limit(5).order('id desc')    
  end

  def not_found
  end

  def payment_success
  end
end
