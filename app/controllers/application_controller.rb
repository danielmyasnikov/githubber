class ApplicationController < ActionController::API
  rescue_from StandardError do |e|
    Sentry.capture_exception(e)
    logger.error("#{e.message} (#{e.class}). Backtrace: #{e.backtrace.first(5)}")
    render json: { message: e.message, backtrace: e.backtrace.first(5) }, status: 500
  end
end
