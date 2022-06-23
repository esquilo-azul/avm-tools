# frozen_string_literal: true

require 'avm/tools/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Subs
          runner_with :help, :output do
            desc 'Output source\'s subs.'
            bool_opt '-R', '--recursive'
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
              b += sub_output_content_lines(sub)
            end
            b.map { |line| "#{line}\n" }.join
          end

          def sub_label(sub)
            sub.path.relative_path_from(runner_context.call(:subject).path).to_s
          end

          def sub_output_content_lines(sub)
            [sub_label(sub)] + sub_subs_output_content_lines(sub)
          end

          def sub_subs_output_content_lines(sub)
            return [] unless parsed.recursive?

            sub.subs.flat_map { |sub_sub| sub_output_content_lines(sub_sub) }
          end
        end
      end
    end
  end
end
