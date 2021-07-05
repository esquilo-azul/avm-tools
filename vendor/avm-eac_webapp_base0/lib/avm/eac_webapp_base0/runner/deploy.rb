# frozen_string_literal: true

require 'avm/instances/runner'
require 'avm/path_string'
require 'eac_cli/core_ext'

module Avm
  module EacWebappBase0
    class Runner < ::Avm::Instances::Runner
      class Deploy
        runner_with :help do
          desc 'Deploy for instance.'
          arg_opt '-r', '--reference', 'Git reference to deploy.'
          arg_opt '-a', '--append-dirs', 'Append directories to deploy (List separated by ":").'
          bool_opt '-T', '--no-request-test', 'Do not test web interface after deploy.'
        end

        def deploy_class
          runner_context.call(:stereotype_module).const_get('Deploy')
        end

        def run
          result = deploy_class.new(runner_context.call(:instance), deploy_options).run
          if result.error?
            fatal_error result.to_s
          else
            infov 'Result', result.label
          end
        end

        def deploy_options
          { reference: parsed.reference,
            appended_directories: ::Avm::PathString.paths(parsed.append_dirs),
            no_request_test: parsed.no_request_test? }
        end
      end
    end
  end
end
