# frozen_string_literal: true

require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module EacWebappBase0
    class Runner < ::Avm::Instances::Runner
      class ApacheHost
        runner_with :help do
          desc 'Configure Apache virtual host for instance.'
          bool_opt '-c', '--certbot', 'Install certbot.'
        end

        def run
          result = stereotype_apache_host_class.new(runner_context.call(:instance),
                                                    stereotype_apache_host_options).run
          if result.error?
            fatal_error result.to_s
          else
            infov 'Result', result.label
          end
        end

        def stereotype_apache_host_class
          "#{runner_context.call(:instance).class.name.deconstantize}::ApacheHost".constantize
        end

        def stereotype_apache_host_options
          { certbot: parsed.certbot? }
        end
      end
    end
  end
end
