module ApplicationHelper

    def show_picture(listing)
        if listing.picture.attached?
            return image_tag(listing.picture, {class: 'thumbnail'})
        else
            return image_tag("duck.png", {class: 'thumbnail'})
        end
    end 

    def show_avatar(listing)
        if listing.user.avatar.attached?
            return image_tag(listing.user.avatar, {class: "card-img-top"})
        else
            return image_tag("default-user-01.png", {class: "card-img-top"})
        end
    end

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

    # when method is called, the listing is parsed in then the editable_by? method is called from the model and the current user id is parsed to it
    def edit(listing)        
        if listing.editable_by?(current_user)
            link_to "edit", edit_listing_path(listing.id), class: "btn btn-primary middle" 
        else
            return
        end
    end

    # when method is called, the listing is parsed in then the deletable_by? method is called from the model and the current user id is parsed to it
    def delete(listing)        
        if listing.deletable_by?(current_user)
            link_to "delete", listing_path(listing),method: :delete,
                data: { confirm: "Are you sure?" }, class: "btn btn-primary"
        else
            return
        end
    end

    

end

