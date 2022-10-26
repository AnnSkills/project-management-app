class HomeController < ApplicationController
  def index
    if account_signed_in?
      ActsAsTenant.current_tenant = current_account
    end
  end
end
