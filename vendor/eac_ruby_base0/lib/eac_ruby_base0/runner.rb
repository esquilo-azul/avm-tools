# frozen_string_literal: true

require 'eac_cli/default_runner'
require 'eac_ruby_utils/core_ext'

module EacRubyBase0
  module Runner
    require_sub __FILE__
    common_concern do
      include ::EacCli::DefaultRunner
      runner_definition do
        bool_opt '-q', '--quiet', 'Quiet mode.'
        subcommands
        alt do
          bool_opt '-V', '--version', 'Show version.'
        end
      end
    end

    def run
      on_speaker_node do |node|
        node.stderr = ::StringIO.new if options.fetch('--quiet')
        if options.fetch('--version')
          show_version
        else
          run_with_subcommand
        end
      end
    end

    def application_version
      context(:application).version.to_s
    end

    def show_version
      out("#{application_version}\n")
    end
  end
end
