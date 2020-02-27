class PagesController < ApplicationController
  def home
   @listings = Listing.limit(5).order('id desc')
  end

  def not_found
  end
end
