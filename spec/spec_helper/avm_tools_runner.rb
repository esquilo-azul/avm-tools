# frozen_string_literal: true

RSpec.configure do |_config|
  def avm_tools_runner_args_prefix
    []
  end

  def avm_tools_runner_run(*argv)
    Avm::Tools::Runner.run(argv: avm_tools_runner_args_prefix + argv)
  end
end
