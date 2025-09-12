# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Subs
          PADDING = '  '

          runner_with :help, :output do
            desc 'Output source\'s subs.'
            bool_opt '-i', '--info'
            bool_opt '-R', '--recursive'
            bool_opt '-t', '--tree'
          end

          def run
            start_banner
            run_output
          end

          def start_banner
            infov 'Include PATH', runner_context.call(:subject).subs_include_path
            infov 'Exclude PATH', runner_context.call(:subject).subs_exclude_path
            infov 'Count', runner_context.call(:subject).subs.count
          end

          def output_content
            b = []
            runner_context.call(:subject).subs.each do |sub|
              b += sub_output_content_lines(sub, 0)
            end
            b.map { |line| "#{line}\n" }.join
          end

          def sub_info_label(sub)
            return '' unless parsed.info?

            ' [' + { # rubocop:disable Style/StringConcatenation
              'CLASS' => sub.class.name,
              'SCM' => sub.scm.class.name
            }.map { |k, v| "#{k}: #{v}" }.join(', ') + ']'
          end

          def sub_label(sub, level)
            sub_self_label(sub, level) + sub_info_label(sub)
          end

          def sub_self_label(sub, level)
            if parsed.tree?
              (PADDING * level) + sub.relative_path.to_s
            else
              sub.path.relative_path_from(runner_context.call(:subject).path).to_s
            end
          end

          def sub_output_content_lines(sub, level)
            [sub_label(sub, level)] + sub_subs_output_content_lines(sub, level)
          end

          def sub_subs_output_content_lines(sub, level)
            return [] unless parsed.recursive?

            sub.subs.flat_map { |sub_sub| sub_output_content_lines(sub_sub, level + 1) }
          end
        end
      end
    end
  end
end
