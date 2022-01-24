# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_cli/speaker'
require 'eac_config/node'
require 'eac_fs/contexts'
require 'eac_ruby_utils/speaker'

module EacRubyBase0
  module Runner
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

    def on_context(&block)
      top_block = block
      available_contexts.each do |context|
        next if context.object.any?

        last_block = top_block
        top_block = ::Proc.new { context.object.on(context.builder.call, &last_block) }
      end
      top_block.call
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

    # @return [Array<EacRubyUtils::Struct>]
    def available_contexts
      (filesystem_available_contexts + [
        [:config, ::EacConfig::Node.context, -> { runner_context.call(:application).build_config }],
        [:speaker, ::EacRubyUtils::Speaker.context, -> { build_speaker }]
      ]).map { |row| available_context_row_to_struct(row) }
    end

    def available_context_row_to_struct(row)
      %i[type object builder].zip(row).to_h.to_struct
    end

    def build_speaker
      options = {}
      options[:err_out] = ::StringIO.new if parsed.quiet?
      options[:in_in] = FailIfRequestInput.new if parsed.no_input?
      ::EacCli::Speaker.new(options)
    end

    def filesystem_available_contexts
      ::EacFs::Contexts::TYPES.map do |type|
        key = "fs_#{type}".to_sym
        [key, ::EacFs::Contexts.send(key).context, -> { application.send("self_#{key}") }]
      end
    end
  end
end
