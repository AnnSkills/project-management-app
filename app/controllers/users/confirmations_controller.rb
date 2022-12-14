class Users::ConfirmationsController < Devise::ConfirmationsController
  set_current_tenant_through_filter
  prepend_before_action :set_tenant

  def set_tenant
    ActsAsTenant.current_tenant = current_account
  end

  def new
    ActsAsTenant.with_tenant(current_account) do
      self.resource = resource_class.new
    end
  end

  def create
    ActsAsTenant.with_tenant(current_account) do
      self.resource = resource_class.send_confirmation_instructions(resource_params)
      yield resource if block_given?
      if successfully_sent?(resource)
        respond_with({}, location: after_resending_confirmation_instructions_path_for(resource_name))
      else
        respond_with(resource)
      end
    end
  end

  def show
    ActsAsTenant.with_tenant(current_account) do
      self.resource = resource_class.confirm_by_token(params[:confirmation_token])
      yield resource if block_given?
      if resource.errors.empty?
        set_flash_message!(:notice, :confirmed)
        respond_with_navigational(resource){ redirect_to after_confirmation_path_for(resource_name, resource) }
      else
        respond_with_navigational(resource.errors, status: :unprocessable_entity){ render :new }
      end
    end
  end
end
