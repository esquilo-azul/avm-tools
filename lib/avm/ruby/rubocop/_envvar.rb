# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/on_clean_ruby_environment'

module Avm
  module Ruby
    class Rubocop
      RUBOCOP_COMMAND_ENVVAR_NAME = 'RUBOCOP_COMMAND'

      def env_rubocop_command
        ENV[RUBOCOP_COMMAND_ENVVAR_NAME].present? ? cmd(ENV[RUBOCOP_COMMAND_ENVVAR_NAME]) : nil
      end
    end
  end
end
