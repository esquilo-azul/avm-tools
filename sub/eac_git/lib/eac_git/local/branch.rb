# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacGit
  class Local
    class Branch
      REFS_PREFIX = 'refs/heads/'

      common_constructor :local, :name

      # @return [String]
      def current_commit_id
        local.rev_parse(full_ref_name, true)
      end

      # @return [Boolean]
      def exist?
        local.command('show-ref', '--quiet', full_ref_name).execute.fetch(:exit_code).zero?
      end

      def full_ref_name
        "#{REFS_PREFIX}#{name}"
      end
    end
  end
end
