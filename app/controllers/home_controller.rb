class HomeController < ApplicationController
  def index
    if user_signed_in?
      @accounts = Account.where('id = ?', current_user.account_id)
      #@accounts = Account.params[:current_user.id]
      ActsAsTenant
      @projects = Project.where('account_id = ?', current_user.account_id)
      #@projects = Project.params[:current_user.account_id]
    end
  end
end
