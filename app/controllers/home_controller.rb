class HomeController < ApplicationController
  def index
    TenantSetting.new.define_tenant_for_signed_in
  end
end
