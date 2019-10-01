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
              __PROGRAM__ [options] <target-url>
              __PROGRAM__ -h | --help

            Options:
              -h --help                    Mostra esta ajuda.
              -r --reference=<reference>   Reference [default: HEAD].
          DOCOPT

          def run
            input_banner
            validate
            main_info_banner
            deploy
          end

          private

          def input_banner
            infov 'Repository', git
            infov 'Reference', reference
          end

          def validate
            return if reference_sha1.present?

            fatal_error "Object ID not found for reference \"#{reference}\""
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
            ::EacLauncher::Git::Base.new(context(:repository_path))
          end

          def deploy
            commit = ::Avm::Git::Commit.new(git, reference_sha1)
            commit.deploy_to_url(options.fetch('<target-url>'))
          end
        end
      end
    end
  end
end
