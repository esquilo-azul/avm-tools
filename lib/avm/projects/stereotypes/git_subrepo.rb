# frozen_string_literal: true

require 'eac_launcher/git/error'
require 'eac_ruby_utils/core_ext'
require 'avm/projects/stereotype'

module Avm
  module Projects
    module Stereotypes
      class GitSubrepo
        require_sub __FILE__
        include Avm::Projects::Stereotype

        class << self
          def match?(path)
            File.exist?(path.real.subpath('.gitrepo')) && subrepo_url(path.real) != 'none'
          end

          def color
            :light_cyan
          end

          def subrepo_url(path)
            File.read(path.subpath('.gitrepo')).each_line do |l|
              m = /remote\s*=\s(.+)/.match(l)
              return m[1] if m
            end
            raise ::EacLauncher::Git::Error.new(path, '"remote = ... " not found')
          end
        end
      end
    end
  end
end
