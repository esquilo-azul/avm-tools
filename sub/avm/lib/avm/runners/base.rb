# frozen_string_literal: true

require 'eac_cli/core_ext'

module Avm
  module Runners
    class Base
      enable_abstract_methods

      class << self
        def command_argument
          stereotype_name.underscore.dasherize
        end

        def stereotype_name
          name.split('::')[-3]
        end
      end

      delegate :command_argument, :stereotype_name, to: :class

      runner_with :help, :subcommands do
        subcommands
      end

      def to_s
        stereotype_name
      end
    end
  end
end
