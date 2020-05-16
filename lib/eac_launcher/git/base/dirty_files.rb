# frozen_string_literal: true

require 'active_support/core_ext/object'

module EacLauncher
  module Git
    class Base < ::EacLauncher::Paths::Real
      module DirtyFiles
        def dirty?
          dirty_files.any?
        end

        def dirty_files
          execute!('status', '--porcelain', '--untracked-files').each_line.map do |line|
            parse_status_line(line.gsub(/\n\z/, ''))
          end
        end

        private

        def parse_status_line(line)
          m = /\A(.)(.)\s(.+)\z/.match(line)
          ::Kernel.raise "Status pattern does not match \"#{line}\"" unless m
          ::OpenStruct.new(index: m[1], worktree: m[2], path: m[3],
                           absolute_path: ::File.expand_path(m[3], self))
        end
      end
    end
  end
end
