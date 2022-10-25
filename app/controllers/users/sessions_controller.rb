class Users::SessionsController < Devise::SessionsController
  set_current_tenant_through_filter
  skip_before_action :verify_authenticity_token
  # GET /resource/sign_in
  def new
    ActsAsTenant.without_tenant do
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      respond_with(resource, serialize_options(resource))
    end
  end

  def create
    ActsAsTenant.without_tenant do
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  def destroy
    ActsAsTenant.without_tenant do
      puts 'test'
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message! :notice, :signed_out if signed_out
      yield if block_given?
      respond_to_on_destroy
    end
  end

  private
  def user_params
    params.require(:user).permit(:id, :email, :password)
  end

  # private
  #
  # def secure_app
  #   self.class.set_current_tenant_through_filter
  # end

  # POST /resource/sign_in


  # DELETE /resource/sign_out


  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
