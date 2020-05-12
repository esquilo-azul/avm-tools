# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_launcher/runner/instances'
require 'eac_launcher/runner/projects'
require 'eac_launcher/runner/publish'

module EacLauncher
  class Runner < ::EacRubyUtils::Console::DocoptRunner
    DOC = <<~DOCOPT
      Utilities to deploy applications and libraries.

      Usage:
        __PROGRAM__ [options] __SUBCOMMANDS__
        __PROGRAM__ -h | --help

      Options:
        -h --help             Show this screen.
    DOCOPT
  end
end
