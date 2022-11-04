class PricesController < ApplicationController
  def index
    @pricing = Stripe::Price.list(limit: 3)
    render 'plans/pricing'
  end
end
