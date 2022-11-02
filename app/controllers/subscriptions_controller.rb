class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def create_subscription
    StripeCreator.new.create
  end
end
