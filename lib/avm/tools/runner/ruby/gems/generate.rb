# frozen_string_literal: true

require 'avm/ruby/gems/generator'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'
require 'eac_cli/default_runner'

module Avm
  module Tools
    class Runner
      class Ruby < ::EacRubyUtils::Console::DocoptRunner
        class Gems < ::EacRubyUtils::Console::DocoptRunner
          class Generate < ::EacRubyUtils::Console::DocoptRunner
            enable_console_speaker
            enable_simple_cache

            DOC = <<~DOCUMENT
              Create a gem.

              Usage:
                __PROGRAM__ [options] <path>
                __PROGRAM__ -h --help

              Options:
                -h --help                                   Show this help.
                --eac-ruby-utils-version=<version>          Version for "eac_ruby_utils" gem.
                --eac-ruby-gem-support-version=<version>    Version for "eac_ruby_gem_support" gem.
            DOCUMENT

            def run
              success "Gem \"#{generator.name}\" created in \"#{generator.root_directory}\""
            end

            private

            def generator_uncached
              ::Avm::Ruby::Gems::Generator.new(options.fetch('<path>'), generator_options)
            end

            def generator_options
              %w[eac_ruby_utils eac_ruby_gem_support].map do |gem_name|
                ["#{gem_name}_version".to_sym, options.fetch("--#{gem_name.dasherize}-version")]
              end.to_h
            end
          end
        end
      end
    end
  end
end
