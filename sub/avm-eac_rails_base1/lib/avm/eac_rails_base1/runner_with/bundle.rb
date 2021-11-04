# frozen_string_literal: true

require 'avm/eac_rails_base1/instance'
require 'avm/eac_rails_base1/runner_with/rails_environment'
require 'eac_cli/runner'

module Avm
  module EacRailsBase1
    module RunnerWith
      module Bundle
        common_concern do
          include ::Avm::EacRailsBase1::RunnerWith::RailsEnvironment
        end

        def bundle_command
          rails_instance.bundle(*bundle_args).envvar('RAILS_ENV', rails_environment)
        end

        def bundle_run
          infov 'Bundle arguments', ::Shellwords.join(bundle_args)
          infov 'Rails environment', rails_environment
          bundle_command.system!
        end
      end
    end
  end
end
