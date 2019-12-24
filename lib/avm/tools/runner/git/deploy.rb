# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/simple_cache'
require 'eac_launcher/git/base'
require 'avm/git/commit'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class Deploy < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::SimpleCache
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Deploy a Git revision to a location (Local or remote).

            Usage:
              __PROGRAM__ [options] [<target-url>]
              __PROGRAM__ -h | --help

            Options:
              -h --help                     Mostra esta ajuda.
              -r --reference=<reference>    Reference [default: HEAD].
              -i --instance=<instance-id>   Read entries from instance with id=<instance-id>.
              -a --append-dirs=<append-dirs>  Append directories to deploy (List separated by ":").
          DOCOPT

          def run
            input_banner
            validate
            main_info_banner
            deploy
            success 'Done'
          end

          private

          def input_banner
            infov 'Repository', git
            infov 'Reference', reference
            infov 'Instance ID', instance_id.if_present('- BLANK -')
            infov 'Appended directories', appended_directories
            infov 'Target URL', target_url
          end

          def validate
            unless reference_sha1.present?
              fatal_error "Object ID not found for reference \"#{reference}\""
            end
            fatal_error 'Nor <target-url> nor --instance was setted' unless target_url.present?
          end

          def main_info_banner
            infov 'Reference SHA1', reference_sha1
          end

          def reference_sha1_uncached
            git.rev_parse(reference)
          end

          def reference
            options.fetch('--reference')
          end

          def git_uncached
            ::EacLauncher::Git::Base.new(git_repository_path)
          end

          def git_repository_path
            if context('repository_path?') || dev_instance_fs_path.blank?
              return context(:repository_path)
            end

            dev_instance_fs_path
          end

          def dev_instance_fs_path
            instance.if_present do |v|
              v.application.instance('dev').read_entry_optional(:fs_path)
            end
          end

          def deploy
            ::Avm::Git::Commit.new(git, reference_sha1)
                              .deploy_to_url(target_url)
                              .append_directories(appended_directories)
                              .variables_source_set(variables_source)
                              .run
          end

          def target_url
            options['<target-url>'].if_present { |v| return v }
            instance.if_present { |v| return v.read_entry('fs.url') }
            nil
          end

          def variables_source
            instance || ::Avm.configs
          end

          def instance_uncached
            instance_id.if_present { |v| ::Avm::Instances::Base.by_id(v) }
          end

          def instance_id
            options.fetch('--instance')
          end

          def appended_directories
            options.fetch('--append-dirs').to_s.split(':')
          end
        end
      end
    end
  end
end
