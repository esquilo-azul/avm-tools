# frozen_string_literal: true

require 'eac_cli/speaker'
require 'eac_ruby_utils/speaker'

class FailIfRequestInput
  %w[gets noecho].each do |method|
    define_method(method) do
      raise "Input method requested: #{method}. Should not request input on RSpec."
    end
  end
end

::RSpec.configure do |config|
  config.around do |example|
    ::EacRubyUtils::Speaker.context.on(
      ::EacCli::Speaker.new(err_out: ::StringIO.new, out_out: ::StringIO.new,
                            in_in: ::FailIfRequestInput.new)
    ) { example.run }
  end
end
