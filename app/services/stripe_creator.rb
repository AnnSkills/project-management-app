class StripeCreator
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def create
    create_stripe_subscription
    @current_user.update(stripe_options)
  end

  private

  def stripe_options
    {
      stripe_id: customer.id,
      subscribed: true,
      card_last4: @params[:user][:card_last4],
      card_exp_month: @params[:user][:card_exp_month],
      card_exp_year: @params[:user][:card_exp_year],
      card_type: @params[:user][:card_brand]
    }
  end

  def create_stripe_subscription
    Stripe::Subscription.create({ customer: customer,
                                  items: [
                                    {
                                      plan: plan
                                    }
                                  ],
                                  expand: ["latest_invoice.payment_intent"],
                                  application_fee_percent: 10,
                                },
                                stripe_acccount: @current_user.stripe_customer_id)
  end

  def customer
    if @current_user.stripe_id?
      Stripe::Customer.retrieve(@current_user.stripe_customer_id)
    else
      Stripe::Customer.create(email: @current_user.email, source: @params[:stripeToken])
    end
  end

  def plan
    Stripe::Plan.retrieve(@params[:plan])
  end
end
