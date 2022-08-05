# frozen_string_literal: true

require 'avm/eac_ruby_base1/source_generators/base'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Ruby
        class Gems
          class Generate
            runner_with :help do
              desc 'Create a gem.'
              arg_opt '--eac-ruby-utils-version', 'Version for "eac_ruby_utils" gem.'
              arg_opt '--eac-ruby-gem-support-version', 'Version for "eac_ruby_gem_support" gem.'
              pos_arg :path
            end

            def run
              success "Gem \"#{generator.name}\" created in \"#{generator.root_directory}\""
            end

            private

            def generator_uncached
              ::Avm::EacRubyBase1::SourceGenerators::Base.new(parsed.path, generator_options)
            end

            def generator_options
              %w[eac_ruby_utils eac_ruby_gem_support].map do |gem_name|
                ["#{gem_name}_version".to_sym, parsed.fetch("#{gem_name.variableize}_version")]
              end.to_h
            end
          end
        end
      end
    end
  end
end
