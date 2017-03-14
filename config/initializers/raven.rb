Raven.configure do |config|
  config.dsn = 'https://5bda8ef0f62549dda213f824ab8a5661:f93ff2307cf34dcead0c4d27fb042d78@sentry.io/147796'
  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
  config.environments = ['production']
end
