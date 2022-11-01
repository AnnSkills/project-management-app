class Users::RegistrationsController < Devise::RegistrationsController
  set_current_tenant_through_filter
end
