# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class VersionBump
          runner_with :help, :confirmation do
            desc 'Bump version of a local project.'
            arg_opt '-n', '--new', 'Set new version.'
            arg_opt '-s', '--segment', 'Increment de <segment>-th segment (Left-most is 0)'
            bool_opt '-M', '--major', 'Same as --segment=0.'
            bool_opt '-m', '--minor', 'Same as --segment=1.'
            bool_opt '-p', '--patch', 'Same as --segment=2.'
          end

          def run
            start_banner
            version_changed? ? run_version_changed : run_version_unchanged
          end

          def run_version_changed
            infom 'Version changed'
            if confirm?
              runner_context.call(:subject).version_bump(target_version)
              success 'Bumped'
            else
              fatal_error 'Bump unconfirmed'
            end
          end

          def run_version_unchanged
            success 'Version unchanged'
          end

          def start_banner
            infov 'Instance', runner_context.call(:subject)
            infov 'Current version', current_version.if_present('-')
            infov 'Target version', target_version.if_present('-')
          end

          def current_version_uncached
            runner_context.call(:subject).if_respond('version')
          end

          def target_version_uncached
            r = current_version
            %w[new segment major minor patch].each do |option|
              option_value = parsed[option]
              next if option_value.blank?

              r = send("target_version_from_#{option}", r, option_value)
            end
            r
          end

          def target_version_from_new(_current, option_value)
            ::Avm::VersionNumber.new(option_value)
          end

          def target_version_from_segment(current, option_value)
            current.increment_segment(option_value.to_i)
          end

          %w[major minor patch].each_with_index do |segment, segment_index|
            define_method "target_version_from_#{segment}" do |current, _option_value|
              target_version_from_segment(current, segment_index)
            end
          end

          def version_changed?
            target_version != current_version
          end
        end
      end
    end
  end
end
