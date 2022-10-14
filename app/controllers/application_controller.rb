class ApplicationController < ActionController::Base

  # before_action :authenticate_user!
  # set_current_tenant_by_subdomain_or_domain(:account, :subdomain, :domain)

  #
  set_current_tenant_through_filter
  before_action :set_current_account

  def set_current_account
    return unless current_user.present?
    current_account = current_user.account
    ActsAsTenant.current_tenant = current_account
  end
  #
  # *******2
  # before_action :configure_permitted_parameters, if: :devise_controller?
  #
  # protected
  #
  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  # end
end
