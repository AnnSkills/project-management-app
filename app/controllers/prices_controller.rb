class PricesController < ApplicationController
  def index
    if user_signed_in?
      @pricing = Stripe::Price.list( {limit: 3})
    end
  end
end
