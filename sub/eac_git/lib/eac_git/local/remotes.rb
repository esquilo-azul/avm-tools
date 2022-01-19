# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_git/local/remote'

module EacGit
  class Local
    module Remotes
      def remote(name)
        ::EacGit::Local::Remote.new(self, name)
      end

      def remotes
        command('remote').execute!.each_line.map(&:strip).reject(&:blank?).map do |name|
          remote(name)
        end
      end
    end
  end
end
