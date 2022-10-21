class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def create
    def create
      checkout_items = checkout_params[:items].map(&:to_h)
      @session = Stripe::Checkout::Session.create({
                                                    customer: current_user.stripe_customer_id,
                                                    success_url: root_url(success: true),
                                                    # success_url: root_url + "success?session_id={CHECKOUT_SESSION_ID}",
                                                    cancel_url: pricing_url,
                                                    line_items: [
                                                      {price: params[:price, :name, :product], quantity: 1},
                                                    ],
                                                    mode: 'subscription',
                                                  })
      redirect_to @session.url, allow_other_host: true
    end

    private

    def checkout_params
      params.require(:checkout).permit(items: [])
    end
    # def create
    #   @session = Stripe::Checkout::Session.create(
    #     customer: current_user.stripe_customer_id,
    #     customer_email: current_user.email, # I added this line
    #     client_reference_id: current_user.id,
    #     success_url: root_url + "success?session_id={CHECKOUT_SESSION_ID}",
    #     cancel_url: pricing_url,
    #     payment_method_types: ['card'],
    #     mode: 'subscription',
    #     line_items: [{
    #                    quantity: 1,
    #                    price: price,
    #                  }]
    #   )
    #   redirect_to @session.url, allow_other_host: true
    # end
    # @session = Stripe::Checkout::Session.create({
    #                                               customer: current_user.stripe_customer_id,
    #                                               success_url: root_url,
    #                                               cancel_url: pricing_url,
    #                                               line_items: [
    #                                                 {price: params[:price], quantity: 1},
    #                                               ],
    #                                               mode: 'subscription',
    #                                             })
    # redirect_to @session.url, allow_other_host: true
  end
end
