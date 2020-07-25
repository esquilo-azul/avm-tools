# frozen_string_literal: true

require 'avm/local_projects/jobs/update'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class LocalProject < ::EacRubyUtils::Console::DocoptRunner
        class Update < ::EacRubyUtils::Console::DocoptRunner
          include ::EacCli::DefaultRunner

          runner_definition do
            desc 'Update local project.'
          end

          def run
            infov 'Path', context(:instance).path
            ::Avm::LocalProjects::Jobs::Update.new(context(:instance)).run
          end
        end
      end
    end
  end
end
