# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/ruby/command'
require 'delegate'

module EacRubyGemsUtils
  class Gem
    class Command < ::EacRubyUtils::Ruby::Command
      attr_reader :gem

      def initialize(gem, command_args, extra_options = {})
        @gem = gem
        super(command_args, extra_options.merge(host_env: gem.host_env))
      end

      # Changes current directory to the gem's directory.
      def chdir_root
        chdir(gem.root.to_path)
      end

      def envvar_gemfile
        envvar('BUNDLE_GEMFILE', gem.gemfile_path.to_path)
      end

      protected

      def duplicate(command, extra_options)
        self.class.new(gem, command, extra_options)
      end
    end
  end
end
