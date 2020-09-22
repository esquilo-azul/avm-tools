# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacWebappBase0
    module Runner
      class ApacheHost < ::EacRubyUtils::Console::DocoptRunner
        include ::EacCli::DefaultRunner

        stereotype_name = name.deconstantize.demodulize
        runner_definition do
          desc "Configure Apache virtual host for #{stereotype_name} instance."
        end

        def run
          options
          result = stereotype_apache_host_class.new(context(:instance)).run
          if result.error?
            fatal_error result.to_s
          else
            infov 'Result', result.label
          end
        end

        def stereotype_apache_host_class
          "#{context(:instance).class.name.deconstantize}::ApacheHost".constantize
        end
      end
    end
  end
end
