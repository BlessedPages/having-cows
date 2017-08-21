if Rails.env.production?
	Rails.configuration.stripe = {
		publishable_key: ENV['STRIPE_PUBLISHABLE_KEY'],
		secret_key: ENV['STRIPE_SECRET_KEY']
	}
else
	Rails.configuration.stripe = {
		publishable_key: 'pk_test_72hPudsbhy9qOOSXAUekZEHt',
		secret_key: 'sk_test_IVUEYTlDxumvafR2J0ZOfdiX'
	}
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]