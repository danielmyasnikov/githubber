Sentry.init do |config|
  config.dsn = 'https://11f9c9afd7984f6c8a69eb050de1385b@o624741.ingest.sentry.io/6255061'
  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end