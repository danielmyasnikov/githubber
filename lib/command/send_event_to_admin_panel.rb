# frozen_string_literal: true

module Command
  class SendEventToAdminPanel
    attr_reader :folder, :content, :requester, :repo_name

    def initialize(folder, repo_name, content)
      @folder = folder
      @content = content
      @repo_name = repo_name
      @requester = Helpers::AdminPanelRequester.new
    end

    def call
      Rails.logger.info(">>> Отправляю в админку данные. Ссылка: #{url}, запрос: #{content}")
      @requester.patch(url, content)
    end

    private

    def url
      "#{ENV['ADMIN_PANEL_BASE_URL']}/admin/courses/#{repo_name}/exercises/#{folder}.json"
    end
  end
end
