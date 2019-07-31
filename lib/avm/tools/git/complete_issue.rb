# frozen_string_literal: true

require 'eac_ruby_utils/simple_cache'

module Avm
  module Tools
    module Git
      class CompleteIssue
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

        def branch
          @git.current_branch
        end

        def branch_hash
          @git.rev_parse("refs/heads/#{branch}")
        end

        def branch_name
          branch.split('/')[-1]
        end

        def issue_id
          m = branch_name.match(/\A#{Regexp.quote('issue_')}(\d+)\z/)
          m ? m[1].to_i : nil
        end

        def remote_master_hash
          remote_hashs['refs/heads/master']
        end

        def remote_branch_hash
          remote_hashs["refs/heads/#{branch}"]
        end

        def remote_tag_hash
          remote_hashs[tag]
        end

        private

        attr_reader :options

        def remote_name
          'origin'
        end

        def check_issue_branch
          raise "Branch is not a issue branch (\"#{branch}\"|\"#{branch_name}\")" unless
            branch_valid?
          raise "Hash not found for \"#{branch}\"" unless branch_hash
        end

        def branch_valid?
          issue_id || options[:no_avm_branch_name]
        end

        def assert_tag
          if tag_hash
            return if tag_hash == branch_hash

            delete_tag
          end
          create_tag
        end

        def delete_tag
          info 'Removendo tag...'
          git(['tag', '-d', branch_name])
        end

        def push
          if pushs.empty?
            info 'PUSH: Nada a enviar'
          else
            info "PUSH: enviando \"#{pushs}\"..."
            git(%w[push origin] + pushs)
          end
        end

        def pushs_uncached
          [master_push, remove_branch_push, tag_push].reject(&:nil?)
        end

        def master_push
          remote_master_hash != branch_hash ? "#{branch_hash}:refs/heads/master" : nil
        end

        def remove_branch_push
          remote_branch_hash ? ":refs/heads/#{branch}" : nil
        end

        def tag_push
          !remote_tag_hash || remote_tag_hash != branch_hash ? tag : nil
        end

        def remove_local_branch
          info 'Removendo branch local...'
          bn = branch_name
          git(['checkout', branch_hash])
          git(['branch', '-D', bn])
        end

        def tag
          "refs/tags/#{branch_name}"
        end

        def tag_hash
          @git.rev_parse(tag)
        end

        def create_tag
          git(['tag', branch_name, branch_hash])
        end

        def remote_hashs_uncached
          @git.remote_hashs(remote_name)
        end

        def git(args, exit_outputs = {})
          r = @git.execute!(args, exit_outputs: exit_outputs)
          r.is_a?(String) ? r.strip : r
        end
      end
    end
  end
end
