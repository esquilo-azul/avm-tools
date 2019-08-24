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
        end

        def start_banner
          validations_banner
        end

        def run
          return false unless valid?

          assert_tag
          push
          remove_local_branch
          true
        end

        def issue_id
          m = branch_name.match(/\A#{Regexp.quote('issue_')}(\d+)\z/)
          m ? m[1].to_i : nil
        end

        private

        attr_reader :options

        def git(args, exit_outputs = {})
          r = @git.execute!(args, exit_outputs: exit_outputs)
          r.is_a?(String) ? r.strip : r
        end
      end
    end
  end
end
