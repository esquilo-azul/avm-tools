# frozen_string_literal: true

require 'eac_cli/speaker'

class FailIfRequestInput
  %w[gets noecho].each do |method|
    define_method(method) do
      raise "Input method requested: #{method}. Should not request input on RSpec."
    end
  end
end

::EacCli::Speaker.current_node.configure do |c|
  c.stderr = ::StringIO.new
  c.stdout = ::StringIO.new
  c.stdin = ::FailIfRequestInput.new
end
