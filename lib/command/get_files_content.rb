# frozen_string_literal: true

module Command
  class GetFilesContent
    attr_reader :repo_name, :folder, :files, :requester

    def initialize(repo_name, folder, files)
      @repo_name = repo_name
      @folder = folder
      @files = files
      @requester = Helpers::GithubRequester.new
    end

    def call
      files_content = {}

      files.each do |file_name|
        key = file_name.gsub('.py', '')
        response = requester.get(url(file_name))
        files_content[key] = Base64.decode64(response[:content]).force_encoding('utf-8')
      end

      {
        id: folder,
        course_id: repo_name,
        commit: 'api-update',
        exercise: files_content
      }
    end

    private

    def url(file)
      "repos/#{ENV['REPO_OWNER_LOGIN']}/#{repo_name}/contents/#{folder}/#{file}"
    end

  end
end
