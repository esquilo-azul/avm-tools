# frozen_string_literal: true

module Avm
  module Git
    class Commit
      class Deploy
        module Appended
          require_sub __FILE__

          def appended
            @appended ||= []
          end

          def append_directory(directory)
            appended << ::Avm::Git::Commit::Deploy::Appended::Directory.new(self, directory)
            self
          end

          def append_directories(directories)
            directories.each { |directory| append_directory(directory) }
            self
          end

          def copy_appended_directory(directory)
            raise 'Variables source not set' if variables_source.blank?

            ::EacRubyUtils::Templates::Directory.new(directory).apply(variables_source, build_dir)
          end

          def copy_appended_content
            appended.each(&:copy_to_build_dir)
          end
        end
      end
    end
  end
end
