# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Info < ::EacRubyUtils::Console::DocoptRunner
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Show information about local project instance.'
          end

          def run
            infov 'Path', context(:instance).path
            infov 'Stereotypes', context(:instance).stereotypes.map(&:label).join(', ')
          end
        end
      end
    end
  end
end
