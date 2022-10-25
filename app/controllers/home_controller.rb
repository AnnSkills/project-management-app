class HomeController < ApplicationController
  def index
    if user_signed_in?
      ActsAsTenant.current_tenant = current_user.account.id
    end

       # Account.where('id = ?', current_user.account_id)
        #Account.find_by(id: current_user.account_id)
      #  User.find_by(id: current_user.id)
       #@accounts = Account.where('id = ?',  current_user.account.id)
      #@accounts = Account.params[:current_user.id]
        # ActsAsTenant.current_tenant = 4
        #Account.find_by(id: current_user.account_id)
       #@projects = Project.where('account_ids = ?',  current_user.account.id)
      #@projects = Project.params[:current_user.account_id]
       # end
  end
end
