class CheckoutController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :authenticate_account!

    def create
      @session = Stripe::Checkout::Session.create({
                                                    customer: current_user.stripe_customer_id,
                                                    success_url: root_url(success: true),
                                                    cancel_url: pricing_url,
                                                    line_items: [
                                                      {price: params[:price], quantity: 1}
                                                    ],
                                                  })
      redirect_to @session.url, allow_other_host: true
    end
end
