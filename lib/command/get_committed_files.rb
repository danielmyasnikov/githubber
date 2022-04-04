module Command
  class GetCommittedFiles
    class << self
      def call(commits)
        files = {}

        commits.each do |commit|
          [:added, :modified].each do |change_type|
            commit[change_type].each do |file_path|
              folder, file_name = file_path.split('/')
              files[folder] = [] unless files[folder]
              files[folder] = files[folder] << file_name unless files[folder].include?(file_name)
            end
          end
        end

        files
      end
    end
  end
end