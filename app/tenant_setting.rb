class TenantSetting
  def define_tenant_for_signed_in(current_account)
      ActsAsTenant.current_tenant = current_account
  end
end
