# frozen_string_literal: true

require 'eac_launcher/git/error'
require 'eac_launcher/stereotype'

module EacLauncher
  module Stereotypes
    class GitSubrepo
      include EacLauncher::Stereotype

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
