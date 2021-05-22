# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/patches/class/i18n'

module Avm
  module Projects
    module Stereotypes
      class Git
        class Update
          require_sub __FILE__
          enable_simple_cache
          enable_speaker
          common_constructor :instance

          delegate :git_repo, to: :instance

          def run
            clean_all
            selected_subrepos.map do |f|
              infov 'Subrepo', f
              on_speaker_node do |node|
                node.stderr_line_prefix = '  '
                ::Avm::Projects::Stereotypes::Git::Update::Subrepo.new(self, f).run
              end
            end
          end

          def selected_subrepos_uncached
            git_repo.command('subrepo', '-q', 'status').execute!.split("\n").map(&:strip)
                    .select(&:present?).map(&:to_pathname)
          end

          def clean_all
            infom 'Cleaning'
            git_repo.command('subrepo', 'clean', '--all').execute!
          end
        end
      end
    end
  end
end
