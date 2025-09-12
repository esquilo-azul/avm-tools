# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Entry
          runner_with :help, :output do
            desc 'Retorna valor de uma entrada de instância AVM.'
            bool_opt '-d', '--debug'
            pos_arg :envvar_suffix, repeat: true
          end

          def run
            debug
            run_output
          end

          def output_content
            parsed.envvar_suffix.map { |entry_key| "#{instance.entry(entry_key).value}\n" }.join
          end

          def debug
            return unless parsed.debug?

            parsed.envvar_suffix.map { |entry_key| debug_entry(entry_key) }
          end

          def debug_entry(entry_key)
            infov 'Entry key', entry_key
            e = instance.entry(entry_key)
            infov '  * Type', e.class
            infov '  * Full path', e.full_path
            infov '  * Found?', e.context_found?
            infov '  * Value', e.value
          end
        end
      end
    end
  end
end
