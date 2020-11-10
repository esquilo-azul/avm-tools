# frozen_string_literal: true

require 'avm/instances/runner'
require 'avm/path_string'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'

module Avm
  module EacWebappBase0
    class Runner < ::Avm::Instances::Runner
      class Deploy < ::EacRubyUtils::Console::DocoptRunner
        include ::EacRubyUtils::Console::Speaker

        DOC = <<~DOCOPT
          Deploy for instance.

          Usage:
            __PROGRAM__ [options]
            __PROGRAM__ -h | --help

          Options:
            -h --help                       Show this screen.
            -r --reference=<git-reference>  Git reference to deploy.
            -a --append-dirs=<append-dirs>  Append directories to deploy (List separated by ":").
        DOCOPT

        def deploy_class
          context(:stereotype_module).const_get('Deploy')
        end

        def run
          result = deploy_class.new(context(:instance), deploy_options).run
          if result.error?
            fatal_error result.to_s
          else
            infov 'Result', result.label
          end
        end

        def deploy_options
          { reference: options.fetch('--reference'),
            appended_directories: ::Avm::PathString.paths(options.fetch('--append-dirs')) }
        end
      end
    end
  end
end
