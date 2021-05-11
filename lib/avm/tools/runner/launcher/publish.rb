# frozen_string_literal: true

require 'avm/launcher/instances/runner_helper'

module Avm
  module Tools
    class Runner
      class Launcher
        class Publish < ::Avm::Launcher::Instances::RunnerHelper
          DOC = <<~DOCOPT
            Publica projetos ou instâncias.

            Usage:
              __PROGRAM__ [options] [<instance_path>...]
              __PROGRAM__ -h | --help

            Options:
              -h --help             Show this screen.
              --new                 Publish projects not published before.
              -s --stereotype=<st>  Publish only for stereotype <stereotype>.
              --all            Publish all instances.
              -d --dry-run          "Dry run" publishing.
              --pending             Publish only pending.
              --recache             Rewrite instances cache.
              --run                 Confirm publishing.

          DOCOPT

          def run
            ::EacLauncher::Context.current.recache = options['--recache']
            build_publish_options
            instances.each do |i|
              next unless i.options.publishable?

              i.send(instance_method)
            end
          end

          private

          def dry_run?
            options.fetch('--dry-run')
          end

          def instance_method
            run? || dry_run? ? 'publish_run' : 'publish_check'
          end

          def build_publish_options
            ::EacLauncher::Context.current.publish_options = publish_options
          end

          def publish_options
            { new: options.fetch('--new'), stereotype: options.fetch('--stereotype'),
              confirm: run? }
          end

          def run?
            options.fetch('--run') && !dry_run?
          end
        end
      end
    end
  end
end
