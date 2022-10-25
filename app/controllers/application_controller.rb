class ApplicationController < ActionController::Base
  #prepend_before_action :tenant_setting
  set_current_tenant_through_filter
  prepend_before_action :define_current_tenant
  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!



  private
  def define_current_tenant
    ActsAsTenant.without_tenant do
    return unless user_signed_in?
    current_account = current_user.account
    set_current_tenant(current_account)
    end
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
