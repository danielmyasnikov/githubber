module Helpers
  class GithubRequester
    def initialize
      @connection = Faraday.new do |conn|
        conn.options.timeout = 20
        conn.headers = {
          'Content-Type' => 'application/json',
          'Accept' => 'Accept: application/vnd.github.v3+json',
          'Authorization' => "Token #{ENV['GITHUB_USER_TOKEN']}"
        }
      end
    end

    def get(path)
      response = @connection.get("#{base_url}/#{path}")
      if response.success?
        JSON.parse(response.body.to_s.force_encoding('utf-8'), symbolize_names: true)
      else
        Rails.logger.info(">>> Bad response from GitHub. Status: #{response.status}, body: #{response.body}")
      end
    end

    private

    def base_url
      'https://api.github.com'
    end
  end
end