Rails.application.configure do
  Stripe.api_key = Rails.application.credentials[:stripe][:secret]
end
