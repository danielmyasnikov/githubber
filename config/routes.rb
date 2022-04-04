Rails.application.routes.draw do
  namespace :webhooks do
    post 'githubs/push_event', to: 'githubs#push_event'
  end
end
