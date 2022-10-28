class ApplicationController < ActionController::Base
  set_current_tenant_through_filter
<<<<<<< HEAD
  prepend_before_action :set_tenant
  before_action :authenticate_account!

  def set_tenant
    ActsAsTenant.current_tenant = current_account
  end

=======
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

>>>>>>> new
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
<<<<<<< HEAD
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:id, :email])
  end

  def authenticate_inviter!
    authenticate_account!(force: true)
=======
>>>>>>> new
  end
end
