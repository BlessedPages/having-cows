class PaymentsController < ApplicationController

  def create
    token = params[:stripeToken]
    @product = Product.find(params[:product_id]) # Refer to hidden field in show form
    @user = current_user # Devise helper
    # Create a payment token to Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        amount: (@product.price * 100).to_i, #amount in cents
        currency: "zar",
        source: token,
        description: params[:stripeEmail]
      )
      if charge.paid
        Order.create(product_id: @product.id, user_id: @user.id, total: @product.price)
      end

    rescue Stripe::CardError => e # The card has been declined
      body = e.json_body
      err = body[:error]
      flash[:error] = "Unforunately there was an error processing your payment: #{err[:message]}"
    end
  # Redirect user back to products page
  redirect_to product_path(@product)
  end
end
