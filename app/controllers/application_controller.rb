class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  prepend_before_action :set_tenant
  before_action :authenticate_account!
  prepend_before_action :define_current_tenant

  def set_tenant
    ActsAsTenant.current_tenant = current_account
  end

  private
  def define_current_tenant
    set_current_tenant(current_account)
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
