# frozen_string_literal: true

require 'eac_launcher/git/base'
require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/require_sub'
require 'eac_ruby_utils/simple_cache'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Git
    module Issue
      class Complete
        include ::EacRubyUtils::SimpleCache
        include ::EacRubyUtils::Console::Speaker

        def initialize(options)
          @git = ::EacLauncher::Git::Base.new(options.fetch(:dir))
          run
        end

        def run
          check_issue_branch
          assert_tag
          push
          remove_local_branch
        end

        def issue_id
          m = branch_name.match(/\A#{Regexp.quote('issue_')}(\d+)\z/)
          m ? m[1].to_i : nil
        end

        private

        attr_reader :options

        def check_issue_branch
          raise "Branch is not a issue branch (\"#{branch}\"|\"#{branch_name}\")" unless
          branch_valid?
          raise "Hash not found for \"#{branch}\"" unless branch_hash
        end

        def git(args, exit_outputs = {})
          r = @git.execute!(args, exit_outputs: exit_outputs)
          r.is_a?(String) ? r.strip : r
        end
      end
    end
  end
end
