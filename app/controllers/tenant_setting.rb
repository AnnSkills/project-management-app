class TenantSetting
  def define_tenant_for_signed_in
    if account_signed_in?
      ActsAsTenant.current_tenant = current_account
    end
  end
end
