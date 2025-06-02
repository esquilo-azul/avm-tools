# frozen_string_literal: true

RSpec.describe Avm::Tools::Runner::LauncherStereotypes::List do
  def avm_tools_runner_args_prefix
    %w[launcher-stereotypes list]
  end

  it do
    expect { avm_tools_runner_run }.not_to raise_error
  end

  it do
    expect { avm_tools_runner_run('--deprecated') }.not_to raise_error
  end
end
