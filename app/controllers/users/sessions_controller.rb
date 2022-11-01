class Users::SessionsController < Devise::SessionsController
   set_current_tenant_through_filter
   prepend_before_action :set_tenant
   prepend_before_action :require_no_authentication, only: [:new, :create]
   prepend_before_action :allow_params_authentication!, only: :create

   def set_tenant
     set_current_tenant(current_account)
   end

  def new
    ActsAsTenant.without_tenant do
  skip_before_action :verify_authenticity_token

  def new
    ActsAsTenant.with_tenant(current_account) do
      self.resource = resource_class.new(sign_in_params)
      clean_up_passwords(resource)
      yield resource if block_given?
      respond_with(resource, serialize_options(resource))
      end
  end

  def create
    ActsAsTenant.with_tenant(current_account) do
      self.resource = warden.authenticate!(auth_options)
      set_flash_message!(:notice, :signed_in)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  def destroy
    ActsAsTenant.with_tenant(current_account) do
      signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
      set_flash_message! :notice, :signed_out if signed_out
      yield if block_given?

      respond_to do |format|
        format.html { redirect_to new_user_session_url, notice: ' User Log out OK.' }
        format.json { head :no_content }
      end
    end
  end
      respond_to_on_destroy
    end
  end

  private
  def user_params
    params.require(:user).permit(:id, :email, :password)
  end

end
