class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create
    StripeCreator.new(current_user, params).create
    redirect_to root_path, notice: "Your subscription was setup successfully!"
  end

  def destroy
    customer = Stripe::Customer.retrieve(current_user.stripe_id)
    customer.subscriptions.retrieve(params[:id]).delete
    current_user.subscribed = false
    current_user.perk_subscriptions.delete(params[:plan_id])
    current_user.save
    redirect_to root_path, notice: "Your subscription has been cancelled."
  end
end
