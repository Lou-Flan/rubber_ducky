class PaymentsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: [:webhook]
  
    def webhook
      event = Stripe::Event.construct_from(
          params.to_unsafe_h
        )
        # if current_user.id != @listing.user.id then
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
            
              # charges, data, receipt url
              # puts payment_intent.id
              # puts payment_intent.charges.data[0].receipt_url

              order = Order.create(buyer: buyer, listing: listing, striperef: payment_intent.id, receipt: payment_intent.charges.data[0].receipt_url)
              order.save
        when 'payment_method.attached'
            payment_method = event.data.object # contains a Stripe::PaymentMethod
            # Then define and call a method to handle the successful attachment of a PaymentMethod.
            # handle_payment_method_attached(payment_method)
        # ... handle other event types
        else
            # Unexpected event type
            head :no_content
            return
        end
  # success, but don't need to send anything back to Stripe
      head :no_content
    # end 
  end

  def success
    @listing = current_user.orders.last.listing
    @order = current_user.orders.last
  end

end
