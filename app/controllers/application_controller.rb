class ApplicationController < ActionController::Base
  # set_current_tenant_through_filter
   prepend_before_action :set_tenant
  before_action :authenticate_account!

  def set_tenant
    set_current_tenant(current_account)
    ActsAsTenant.current_tenant = current_account
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
