# frozen_string_literal: true

require 'avm/launcher/git/base'
require 'eac_cli/speaker'
require 'eac_ruby_utils/options_consumer'
require 'eac_ruby_utils/require_sub'
require 'eac_ruby_utils/simple_cache'
::EacRubyUtils.require_sub(__FILE__)

module Avm
  module Git
    module Issue
      class Complete
        include ::EacRubyUtils::SimpleCache
        enable_speaker

        attr_reader :skip_validations

        def initialize(options)
          consumer = ::EacRubyUtils::OptionsConsumer.new(options)
          dir, @skip_validations = consumer.consume_all(:dir, :skip_validations)
          validate_skip_validations
          consumer.validate
          @git = ::Avm::Launcher::Git::Base.new(dir)
        end

        def start_banner
          validations_banner
        end

        def run
          return false unless valid?

          assert_tag
          push
          remove_local_branch
          clipboard_copy_tracker_message
          true
        end

        def issue_id
          m = branch_name.match(/\A#{Regexp.quote('issue_')}(\d+)\z/)
          m ? m[1].to_i : nil
        end

        private

        def git(args, exit_outputs = {})
          r = @git.execute!(args, exit_outputs: exit_outputs)
          r.is_a?(String) ? r.strip : r
        end
      end
    end
  end
end
