# frozen_string_literal: true

module Helpers
  class AdminPanelRequester
    def initialize
      @connection = Faraday.new do |conn|
        conn.options.timeout = 20
        conn.headers = {
          'Content-Type' => 'application/json',
          'token' => ENV['ADMIN_PANEL_AUTH_TOKEN']
        }
      end
    end

    def patch(url, body)
      response = @connection.patch(url, body.to_json)
      if response.success?
        JSON.parse(response.body, symbolize_names: true) if response.body.present?
        Rails.logger.info('>>> Данные успешно отправлены в админку')
      else
        Rails.logger.info(">>> Bad response from AdminPanel. Status: #{response.status}, body: #{response.body}")
      end
    end
  end
end