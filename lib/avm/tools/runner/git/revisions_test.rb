# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/console/docopt_runner'
require 'avm/git/revision_test'

module Avm
  module Tools
    class Runner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class RevisionsTest < ::EacRubyUtils::Console::DocoptRunner
          enable_simple_cache
          enable_console_speaker

          DOC = <<~DOCOPT
            Test multiple revisions until a error is found.

            Usage:
              __PROGRAM__ [options]
              __PROGRAM__ -h | --help

            Options:
              -h --help                     Mostra esta ajuda.
              -c --command=<test-command>   Command to test instance.
              -n --no-cache                 Does not use cache.
          DOCOPT

          def run
            fatal_error('Repository is dirty') if context(:git).dirty?

            return_to_branch_on_end do
              infov 'Revisions found', revisions.count
              if revision_with_error
                warn("First revision with error: #{revision_with_error}")
              else
                success('No error found in revisions')
              end
            end
          end

          private

          def return_to_branch_on_end
            current_branch = context(:git).current_branch
            yield
          ensure
            infom "Returning to original branch \"#{current_branch}\""
            context(:git).execute!('checkout', current_branch)
          end

          def revision_with_error_uncached
            revision_with_error = nil
            revisions.each do |revision|
              revision.banner
              unless revision.successful?
                revision_with_error = revision
                break
              end
            end
            revision_with_error
          end

          def revisions_uncached
            context(:git).execute!('log', '--pretty=format:%H', 'origin/master..HEAD')
                         .each_line.map(&:strip).reverse.map do |sha1|
              ::Avm::Git::RevisionTest.new(context(:git), sha1, test_revision_options)
            end
          end

          def test_revision_options
            { test_command: options.fetch('--command'), no_cache: options.fetch('--no-cache') }
          end
        end
      end
    end
  end
end
