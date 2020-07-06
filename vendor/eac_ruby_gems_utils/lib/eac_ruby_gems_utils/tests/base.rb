# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs_cache'
require 'eac_ruby_utils/listable'
require 'eac_ruby_utils/on_clean_ruby_environment'

module EacRubyGemsUtils
  module Tests
    class Base
      include ::EacRubyUtils::Listable

      enable_simple_cache
      lists.add_string :result, :failed, :nonexistent, :successful

      common_constructor :gem

      def elegible?
        dependency_present? && gem.root.join(test_directory).exist?
      end

      def dependency_present?
        gem.gemfile_path.exist? && gem.gemfile_lock_gem_version(dependency_gem).present?
      end

      def name
        self.class.name.demodulize.gsub(/Test\z/, '')
      end

      def stdout_cache
        root_cache.child('stdout')
      end

      def stderr_cache
        root_cache.child('stderr')
      end

      def to_s
        "#{gem}[#{name}]"
      end

      private

      def result_uncached
        return RESULT_NONEXISTENT unless elegible?

        exec_run_with_log ? RESULT_SUCCESSFUL : RESULT_FAILED
      end

      def exec_run
        gem.bundle('exec', *bundle_exec_args).chdir_root.execute
      end

      def exec_run_with_log
        r = exec_run
        stdout_cache.write(r[:stdout])
        stderr_cache.write(r[:stderr])
        r[:exit_code].zero?
      end

      def root_cache
        ::EacRubyUtils.fs_cache.child(gem.root.to_s.parameterize, self.class.name.parameterize)
      end
    end
  end
end
