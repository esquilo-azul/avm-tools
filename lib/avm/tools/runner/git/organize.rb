# frozen_string_literal: true

require 'avm/git/organize/repository'
require 'eac_cli/default_runner'
require 'eac_ruby_utils/console/docopt_runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class Organize < ::EacRubyUtils::Console::DocoptRunner
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Organize branches.'
            bool_opt '-a', '--all', 'Run all organizations.'
            bool_opt '-n', '--no', 'Do not run operations.'
            bool_opt '-o', '--originals', 'Remove refs/original branches.'
            bool_opt '-s', '--subrepos', 'Remove git-subrepo branches.'
            bool_opt '-y', '--yes', 'Run operations without confirmation.'
          end

          def run
            start_banner
            collect_references
            after_collect_banner
            run_operations
          end

          private

          def after_collect_banner
            infov 'Collected references', repository.collected_references.count
            repository.collected_references.each do |ru|
              infov "  * #{ru.reference}", ru.operation
            end
          end

          def collect?(type)
            options.fetch("--#{type}") || options.fetch('--all')
          end

          def collect_references
            %w[subrepos originals].each do |type|
              repository.send("collect_#{type}") if collect?(type)
            end
          end

          def run_operations
            return warn('No operations to run (Run with --help to see options)') if
            repository.collected_references.empty?
            return unless run_operations?

            repository.collected_references.each do |ru|
              info "Doing operation #{ru}..."
              ru.run_operation
            end
          end

          def run_operations?
            return true if options.fetch('--yes')
            return false if options.fetch('--no')

            request_input('Confirm operations?', bool: true)
          end

          def repository_uncached
            ::Avm::Git::Organize::Repository.new(context(:git).eac_git)
          end

          def start_banner
            infov 'Repository', repository
          end
        end
      end
    end
  end
end
