class Accounts::SessionsController < Devise::SessionsController
<<<<<<< HEAD
  skip_before_action :verify_authenticity_token

=======
  set_current_tenant_through_filter
  skip_before_action :verify_authenticity_token
  # GET /resource/sign_in
>>>>>>> new
  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    yield resource if block_given?
    respond_with(resource, serialize_options(resource))
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end
<<<<<<< HEAD
=======

  private
  def user_params
    params.require(:account).permit(:id, :email, :password)
  end
>>>>>>> new
end
