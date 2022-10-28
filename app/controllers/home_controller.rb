class HomeController < ApplicationController
  def index
<<<<<<< HEAD

=======
    if account_signed_in?
      ActsAsTenant.current_tenant = current_account
    end
>>>>>>> new
  end
end
