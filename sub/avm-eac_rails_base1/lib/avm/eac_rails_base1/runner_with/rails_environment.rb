# frozen_string_literal: true

require 'avm/eac_rails_base1/instance'
require 'eac_cli/runner'

module Avm
  module EacRailsBase1
    module RunnerWith
      module RailsEnvironment
        DEFAULT_RAILS_ENVIRONMENT_CONSTANT = 'DEFAULT_RAILS_ENVIRONMENT'

        common_concern do
          include ::EacCli::Runner

          runner_definition do
            arg_opt '-e', '--environment', 'Specifies the environment for the runner to operate' \
              ' (test/development/production). Default: "development".'
          end
        end

        module ClassMethods
          def default_rails_environment
            const_get(DEFAULT_RAILS_ENVIRONMENT_CONSTANT)
          rescue ::NameError
            ::Avm::EacRailsBase1::Instance::DEFAULT_RAILS_ENVIRONMENT
          end
        end

        def default_rails_environment
          self.class.default_rails_environment
        end

        def rails_environment
          parsed.environment.presence || default_rails_environment
        end

        def rails_instance
          if respond_to?(:runner_context)
            runner_context.call(:instance)
          else
            context(:instance)
          end
        end
      end
    end
  end
end
