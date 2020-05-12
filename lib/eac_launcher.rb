# frozen_string_literal: true

GIT_SUBREPO_LIB = ::File.join(::File.dirname(__dir__), 'vendor', 'git-subrepo', 'lib')
ENV['PATH'] = "#{GIT_SUBREPO_LIB}#{::File::PATH_SEPARATOR}#{ENV['PATH']}"

module EacLauncher
  require 'eac_launcher/context'
  require 'eac_launcher/paths'
  require 'eac_launcher/project'
  require 'eac_launcher/stereotype'
  require 'eac_launcher/git'
  require 'eac_launcher/instances'
  require 'eac_launcher/publish'
  require 'eac_launcher/ruby'
  require 'eac_launcher/stereotypes'
  require 'eac_launcher/vendor'
end
