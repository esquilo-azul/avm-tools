# frozen_string_literal: true

require 'eac_cli/core_ext'
require 'eac_ruby_gems_utils/tests/multiple'

module EacRubyBase0
  module Runner
    class TestAll
      runner_with :help do
        desc 'Test core and local gems.'
      end

      def run
        fatal_error 'Some test did not pass' unless tests.ok?
      end

      def tests_uncached
        ::EacRubyGemsUtils::Tests::Multiple.new(runner_context.call(:application).all_gems)
      end
    end
  end
end
