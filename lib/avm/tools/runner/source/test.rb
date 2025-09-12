# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Source < ::Avm::Sources::Runner
        class Test
          runner_with :help do
            desc 'Test local project.'
            bool_opt '-a', '--all', 'Same as "--self --subs".'
            bool_opt '-f', '--fail-fast', 'Abort after first failure.'
            bool_opt '-m', '--main', 'Test main source.'
            bool_opt '-s', '--subs', 'Test subs\' sources.'
            pos_arg :source_id, repeat: true, optional: true
          end

          def run
            reset_tested_units
            start_banner
            show_units_results
            final_result
          end

          private

          attr_accessor :tested_units

          def failed_units
            tested_units.select(&:failed?)
          end

          def final_result
            if failed_units.any?
              failed_units.each do |unit|
                infov '  * Source', unit
                info unit.logs.truncate_all
              end
              fatal_error 'Some test did not pass'
            else
              success 'None test failed'
            end
          end

          def include_main?
            parsed.main? || parsed.all?
          end

          def include_subs?
            parsed.subs? || parsed.all?
          end

          def reset_tested_units
            self.tested_units = []
          end

          def show_units_results
            test_performer.units.each do |unit|
              infov unit, unit_result(unit)
              tested_units << unit
              break if unit.failed? && parsed.fail_fast?
            end
          end

          def start_banner
            runner_context.call(:source_banner)
            infov 'Selected units', test_performer.units.count
          end

          def test_builder
            r = ::Avm::Sources::Tests::Builder.new(runner_context.call(:subject))
                  .include_main(include_main?)
                  .include_subs(include_subs?)
            parsed.source_id.inject(r) { |a, e| a.include_id(e) }
          end

          def test_performer_uncached
            test_builder.performer
          end

          def unit_result(unit)
            (
              [unit.result.to_label] +
                %i[stdout stderr].map { |label| "#{label.to_s.upcase}: #{unit.logs[label]}" }
            ).join(' | '.blue)
          end
        end
      end
    end
  end
end
