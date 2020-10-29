# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'avm/eac_webapp_base0/runner/apache_host'
require 'eac_ruby_utils/console/docopt_runner'
require 'avm/eac_rails_base0/apache_path'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRailsBase0 < ::Avm::EacRailsBase1::Runner
        class ApachePath < ::EacRubyUtils::Console::DocoptRunner
          runner_with

          runner_definition do
            desc 'Configure Apache path configuration for instance.'
          end

          def run
            if result.error?
              fatal_error result.to_s
            else
              infov 'Result', result.label
            end
          end

          def apache_path_uncached
            ::Avm::EacRailsBase0::ApachePath.new(context(:instance))
          end

          def result_uncached
            apache_path.run
          end
        end
      end
    end
  end
end
