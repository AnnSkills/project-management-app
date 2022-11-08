class PricesController < ApplicationController
  def index
    @pricings = Stripe::Price.list(limit: 3)
    render 'plans/index'
  end
end
