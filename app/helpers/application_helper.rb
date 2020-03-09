module ApplicationHelper
#-----------------------------------------------------------------------
# the current listing is parsed in and checked for an attached or
# default picture to display
#-----------------------------------------------------------------------  
    def show_picture(listing)
        if listing.picture.attached?
            return image_tag(listing.picture, {class: 'thumbnail'})
        else
            return image_tag("duck.png", {class: 'thumbnail'})
        end
    end 

#-----------------------------------------------------------------------
# the current user is parsed in and checked for an attached or
# default avatar to display
#-----------------------------------------------------------------------  
    def show_avatar(listing)
        if listing.user.avatar.attached?
            return image_tag(listing.user.avatar, {class: "icon"})
        else
            return image_tag("user.png", {class: "icon"})
        end
    end

#-----------------------------------------------------------------------
# the current listing is parsed in, a current_user has to be logged in
# in order for the favourite/unfavourite buttons to show. unless condition
# checks whether the current listing is in the current users favourites
# and displays an empty heart to click and favourite. if the user has favourited
# then a full heart is displayed. two conditionals refer to favorite method in
# listings controller which adds and removes a favourite row from the favourites
# table.
#-----------------------------------------------------------------------  
    def favourites(listing)
        if current_user
            unless current_user.favorite_ids.include? listing.id
                return link_to image_tag("favourite.png"), favorite_listing_path(listing, type: "favorite"), method: :put 
            else
                return link_to image_tag("unfavourite.png"), favorite_listing_path(listing, type: "unfavorite"), method: :put
            end
        else
        end
    end

    def get_number_of_favourites(listing)
        number = listing.favorite_listings.count
        if number == nil
            number =  0
        end
        return number
    end

#-----------------------------------------------------------------------
# method is working with editable_by? model method to determine whether the
# current listing belongs to the current user and whether to show the edit button
#-----------------------------------------------------------------------  
    def edit(listing)        
        if listing.editable_by?(current_user)
            link_to "edit", edit_listing_path(listing.id), class: "btn btn-primary middle" 
        else
            return
        end
    end


#-----------------------------------------------------------------------
# method is working with deletable_by? model method to determine whether the
# current listing belongs to the current user and whether to show the delete button
#-----------------------------------------------------------------------  
    def delete(listing)        
        if listing.deletable_by?(current_user)
            link_to "delete", listing_path(listing),method: :delete,
                data: { confirm: "Are you sure?" }, class: "btn btn-danger"
        else
            return
        end
    end

#-----------------------------------------------------------------------
# displays different bootstrao styling based on the flash level
#-----------------------------------------------------------------------  
    def flash_class(level)
    case level
        when 'notice' then "alert alert-info"
        when 'success' then "alert alert-success"
        when 'error' then "alert alert-danger"
        when 'alert' then "alert alert-warning"
    end
    end

#-----------------------------------------------------------------------
# current users listings are parsed in, the method counts and returns
# the number of each true and false value in the listings purchased column
#-----------------------------------------------------------------------  
    def get_sold_active_listings_count(listings)
        active = listings.where(purchased: false).count
        sold = listings.where(purchased: true).count

        return "Active ducks: #{active}   Sold ducks: #{sold}"
    end

#-----------------------------------------------------------------------
# displays icons instead of a list of experiences by checking the 
# experience id
#-----------------------------------------------------------------------  
    def display_language_icons(listing)
        case listing
        when 1 then image_tag("ruby.jpeg", {class: "icon-sm"})
        when 2 then image_tag("javascript.png", {class: "icon-sm"})
        when 3 then image_tag("shell.png", {class: "icon-sm"})
        when 4 then image_tag("python.jpeg", {class: "icon-sm"})
        when 5 then image_tag("Csharp.png", {class: "icon-sm"})
        end

    end

end
