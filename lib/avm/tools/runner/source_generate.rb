# frozen_string_literal: true

require 'avm/runners/base'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class SourceGenerate
        runner_with :help do
          pos_arg :stereotype_name
          pos_arg :target_path
        end

        def run
          start_banner
          generate
        end

        def generate
          infom 'Generating...'
          generator.perform
          success "Source generated in \"#{generator.target_path}\""
        end

        def start_banner
          infov 'Stereotype', stereotype_name
          infov 'Target path', target_path
          infov 'Generator', generator.class
        end

        def generator_uncached
          ::Avm::Registry.source_generators.detect_optional(stereotype_name, target_path) ||
            fatal_error("No generator found for stereotype \"#{stereotype_name}\"")
        end

        delegate :stereotype_name, to: :parsed

        def target_path
          parsed.target_path.to_pathname
        end
      end
    end
  end
end
