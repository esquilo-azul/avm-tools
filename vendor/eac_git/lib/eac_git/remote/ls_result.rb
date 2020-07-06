# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacGit
  class Remote
    class LsResult
      class << self
        def by_ls_remote_command_output(output)
          new(
            output.each_line.map { |line| line.strip.split(/\s+/) }.map { |x| [x[1], x[0]] }.to_h
          )
        end
      end

      common_constructor :hashes
      delegate :fetch, :'[]', :count, :any?, :empty?, to: :hashes
    end
  end
end
