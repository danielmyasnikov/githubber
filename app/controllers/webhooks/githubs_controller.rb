# frozen_string_literal: true

module Webhooks
  class GithubsController < ApplicationController
    def push_event
      committed_files = Command::GetCommittedFiles.call(commits)

      committed_files.each do |folder, files|
        content = Command::GetFilesContent.new(repo_name, folder, files).call
        Command::SendEventToAdminPanel.new(folder, repo_name, content).call
      end
    end

    private

    def commits
      @commits ||= params[:commits]
    end

    def repo_name
      @repo_name ||= params[:repository][:name]
    end
  end
end
