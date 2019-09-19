# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/simple_cache'
require 'eac_launcher/git/base'
require 'filesize'
require 'avm/git/commit'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class Git < ::EacRubyUtils::Console::DocoptRunner
        class Commit < ::EacRubyUtils::Console::DocoptRunner
          include ::EacRubyUtils::SimpleCache
          include ::EacRubyUtils::Console::Speaker

          DOC = <<~DOCOPT
            Mostra informações de um commit.

            Usage:
              __PROGRAM__ [options] <ref>
              __PROGRAM__ -h | --help

            Options:
              -h --help        Mostra esta ajuda.
              -C <git-local>   Caminho do repositório local [default: .].
              -f --files       Mostra os arquivos.
              -s --size        Mostra o tamanho de arquivos.
          DOCOPT

          def run
            input_banner
            validate
            main_info_banner
            files_banner
            size_banner
          end

          private

          def input_banner
            infov 'Repository', git
            infov 'Reference', reference
          end

          def validate
            return if reference_id.present?

            fatal_error "Object ID not found for reference \"#{reference}\""
          end

          def main_info_banner
            infov 'Reference ID', reference_id
            infov 'Subject', commit.subject
            infov 'Author', commit.author_all
            infov 'Commiter', commit.commiter_all
            infov 'Files', commit.files.count
          end

          def size_banner
            return unless show_size?

            infov 'Total files size', bytes_size(commit.files_size)
          end

          def files_banner
            return unless options.fetch('--files')

            commit.files.each do |file|
              infov "  #{file.path}", file_value(file)
            end
          end

          def file_value(file)
            s = "status: #{file.status}"
            s += ", size: #{bytes_size(file.dst_size)}" if show_size?
            s
          end

          def reference_id
            git.rev_parse(reference)
          end

          def reference
            options.fetch('<ref>')
          end

          def git_uncached
            ::EacLauncher::Git::Base.new(options.fetch('-C'))
          end

          def commit_uncached
            ::Avm::Git::Commit.new(git, reference_id)
          end

          def human_files_size
            ::Filesize.from("#{commit.files_size} B").pretty
          end

          def bytes_size(size)
            b = "#{size} B"
            "#{::Filesize.from(b).pretty} (#{b})"
          end

          def show_size?
            options.fetch('--size')
          end
        end
      end
    end
  end
end
