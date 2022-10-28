class BillingPortalController < ApplicationController
  before_action :authenticate_user!

  def create
    session = Stripe::BillingPortal::Session.create({
                                                      customer: current_user.stripe_customer_id,
                                                      return_url: root_url
                                                    })
<<<<<<< HEAD

=======
    # byebug
    # redirect_to  allow_other_host: true, status: :found, host: session.url
>>>>>>> new
    redirect_to session.url, allow_other_host: true
  end
end
