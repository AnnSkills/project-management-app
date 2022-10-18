class ApplicationController < ActionController::Base
  set_current_tenant_by_subdomain(:account, :subdomain)

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_stripe_key # add this line


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  # add the code below
  private
  def set_stripe_key
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
  end

  # before_action :authenticate_user!
  # set_current_tenant_by_subdomain_or_domain(:account, :subdomain, :domain)

  #
  #  set_current_tenant_through_filter
  # before_action :set_current_account
  #
  # def set_current_account
  #   return unless current_user.present?
  #   current_account = current_user.account
  #   ActsAsTenant.current_tenant = current_account
  # end
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
