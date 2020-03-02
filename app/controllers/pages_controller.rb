class PagesController < ApplicationController
  def home
   @listings = Listing.where(purchased: :false).limit(5).order('id desc')
    
  end

  def not_found
  end

  def payment_success
  end
end
