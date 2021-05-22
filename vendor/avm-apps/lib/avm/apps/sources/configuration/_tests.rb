# frozen_string_literal: true

require 'avm/patches/eac_ruby_gems_utils/gem'

module Avm
  module Apps
    module Sources
      class Configuration < ::EacConfig::OldConfigs
        BUNDLE_TEST_COMMAND_KEY = 'test.bundle_command'
        TEST_COMMAND_KEY = 'test.command'

        def any_test_command
          bundle_test_command || test_command
        end

        def test_command
          read_command(TEST_COMMAND_KEY)
        end

        def bundle_test_command
          read_entry(BUNDLE_TEST_COMMAND_KEY).if_present do |v|
            args = v.is_a?(::Enumerable) ? v.map(&:to_s) : ::Shellwords.split(v)
            ::EacRubyGemsUtils::Gem.new(::File.dirname(storage_path)).bundle(*args).chdir_root
          end
        end
      end
    end
  end
end
