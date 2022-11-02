class StripeCreator
  def create

    plan_id = params[:plan]
    plan = Stripe::Plan.retrieve(plan_id)
    token = params[:stripeToken]


    customer = if current_user.stripe_id?
                 Stripe::Customer.retrieve(current_user.stripe_customer_id)
               else
                 Stripe::Customer.create(email: current_user.email, source: token)
               end

    subscription = Stripe::Subscription.create({
                                                 customer: customer,
                                                 items: [
                                                   {
                                                     plan: plan
                                                   }
                                                 ],
                                                 expand: ["latest_invoice.payment_intent"],
                                                 application_fee_percent: 10,
                                               }, stripe_acccount: current_user.stripe_customer_id)

    options = {
      stripe_id: customer.id,
      subscribed: true,
    }

    options.merge!(
      card_last4: params[:user][:card_last4],
      card_exp_month: params[:user][:card_exp_month],
      card_exp_year: params[:user][:card_exp_year],
      card_type: params[:user][:card_brand]
    )
    current_user.update(options)

    redirect_to root_path, notice: "Your subscription was setup successfully!"
  end

  def destroy
    subscription_to_remove = params[:id]
    plan_to_remove = params[:plan_id]
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(subscription_to_remove).delete
    current_user.subscribed = false
    current_user.perk_subscriptions.delete(plan_to_remove)
    current_user.save
    redirect_to root_path, notice: "Your subscription has been cancelled."
  end
end
