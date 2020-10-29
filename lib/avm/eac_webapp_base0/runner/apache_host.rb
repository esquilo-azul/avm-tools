# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    class Runner < ::Avm::Instances::Runner
      class ApacheHost < ::EacRubyUtils::Console::DocoptRunner
        include ::EacCli::DefaultRunner

        runner_definition do
          desc 'Configure Apache virtual host for instance.'
          bool_opt '-c', '--certbot', 'Install certbot.'
        end

        def run
          options
          result = stereotype_apache_host_class.new(context(:instance),
                                                    stereotype_apache_host_options).run
          if result.error?
            fatal_error result.to_s
          else
            infov 'Result', result.label
          end
        end

        def stereotype_apache_host_class
          "#{context(:instance).class.name.deconstantize}::ApacheHost".constantize
        end

        def stereotype_apache_host_options
          { certbot: options.fetch('--certbot') }
        end
      end
    end
  end
end
