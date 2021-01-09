# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner
      class LocalProject < ::EacRubyUtils::Console::DocoptRunner
        class Update < ::EacRubyUtils::Console::DocoptRunner
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Update local project.'
          end

          def run
            infov 'Path', context(:instance).path
            context(:instance).run_job(:update)
          end
        end
      end
    end
  end
end
