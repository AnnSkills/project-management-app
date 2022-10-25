class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
  prepend_before_action :define_current_tenant
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_account!

  private
  def define_current_tenant
    set_current_tenant(current_account)
    ActsAsTenant.current_tenant = current_account
  end

  # def tenant_setting
  #   self.class.set_current_tenant_through_filter
  # end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
