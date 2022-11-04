class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  before_action :authenticate_account!
  prepend_before_action :set_tenant

  def set_tenant
    ActsAsTenant.current_tenant = current_account
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:id, :email])
  end

  def authenticate_inviter!
    authenticate_account!(force: true)
  end
end
