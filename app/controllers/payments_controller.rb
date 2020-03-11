class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]
  
    def webhook
      event = Stripe::Event.construct_from(
          params.to_unsafe_h
        )
        # Handle the event
        case event.type
        when 'payment_intent.succeeded'
            payment_intent = event.data.object # contains a Stripe::PaymentIntent
            # Then define and call a method to handle the successful payment intent.
            # handle_payment_intent_succeeded(payment_intent)
            buyer = User.find(payment_intent.metadata.user_id)
            listing = Listing.find(payment_intent.metadata.listing_id)
            listing.purchased = true
            listing.save
#-----------------------------------------------------------------------
# a new order row is created upon payment intent success and attribute data parsed
#----------------------------------------------------------------------- 
            order = Order.create(buyer: buyer, listing: listing, striperef: payment_intent.id, receipt: payment_intent.charges.data[0].receipt_url)
            order.save
        when 'payment_method.attached'
            payment_method = event.data.object # contains a Stripe::PaymentMethod
        else
            # Unexpected event type
            head :no_content
            return
        end
  # success, but don't need to send anything back to Stripe
      head :no_content
    # end 
  end

#-----------------------------------------------------------------------
# the current users most recent order row is returned 
#----------------------------------------------------------------------- 
  def success
    @listing = current_user.orders.last.listing
    @order = current_user.orders.last
  end

end
