# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_cli/speaker'
require 'eac_config/node'
require 'eac_fs/cache'
require 'eac_ruby_utils/speaker'

module EacRubyBase0
  module Runner
    require_sub __FILE__
    enable_speaker
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
      on_context do
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

    def on_context
      ::EacRubyUtils::Speaker.context.on(build_speaker) do
        ::EacConfig::Node.context.on(runner_context.call(:application).build_config) do
          ::EacFs::Cache.context.on(application.self_fs_cache) do
            yield
          end
        end
      end
    end

    def show_version
      out("#{application_version}\n")
    end

    class FailIfRequestInput
      enable_speaker

      %w[gets noecho].each do |method|
        define_method(method) do
          raise "Input method requested (\"#{method}\") and option --no-input is set"
        end
      end
    end

    private

    def build_speaker
      options = {}
      options[:err_out] = ::StringIO.new if parsed.quiet?
      options[:in_in] = FailIfRequestInput.new if parsed.no_input?
      ::EacCli::Speaker.new(options)
    end
  end
end
