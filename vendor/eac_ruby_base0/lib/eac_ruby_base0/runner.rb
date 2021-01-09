# frozen_string_literal: true

require 'eac_cli/runner_with/help'
require 'eac_cli/runner_with/subcommands'
require 'eac_ruby_utils/core_ext'

module EacRubyBase0
  module Runner
    require_sub __FILE__
    enable_console_speaker
    common_concern do
      include ::EacCli::RunnerWith::Help
      include ::EacCli::RunnerWith::Subcommands
      runner_definition do
        bool_opt '-q', '--quiet', 'Quiet mode.'
        bool_opt '-I', '--no-input', 'Fail if a input is requested.'
        subcommands
        alt do
          bool_opt '-V', '--version', 'Show version.', usage: true, required: true
        end
      end
    end

    def run
      on_speaker_node do |node|
        node.stderr = ::StringIO.new if parsed.quiet?
        node.stdin = FailIfRequestInput.new if parsed.no_input?
        if parsed.version?
          show_version
        else
          run_with_subcommand
        end
      end
    end

    def application_version
      runner_context.call(:application).version.to_s
    end

    def show_version
      out("#{application_version}\n")
    end

    class FailIfRequestInput
      enable_console_speaker

      %w[gets noecho].each do |method|
        define_method(method) do
          raise "Input method requested (\"#{method}\") and option --no-input is set"
        end
      end
    end
  end
end
