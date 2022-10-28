class CheckoutController < ApplicationController
  before_action :authenticate_user!
    def create
      checkout_items = checkout_params[:items].map(&:to_h)
      @session = Stripe::Checkout::Session.create({
                                                    customer: current_user.stripe_customer_id,
                                                    success_url: root_url(success: true),
                                                    cancel_url: pricing_url,
                                                    line_items: [
                                                      {price: params[:price], quantity: 1},
                                                    ],
                                                    mode: 'subscription',
                                                  })
      redirect_to @session.url, allow_other_host: true
    end

    def checkout_params
      params.require(:checkout).permit(items: [])
    end
  end
