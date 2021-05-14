# frozen_string_literal: true

require 'avm/launcher/instances/runner_helper'

module Avm
  module Tools
    class Runner
      class Launcher
        class Publish < ::Avm::Launcher::Instances::RunnerHelper
          runner_with :help do
            desc 'Publica projetos ou instâncias.'
            bool_opt '--all', 'Get all instances.'
            bool_opt '-d', '--dry-run', '"Dry run" publishing.'
            bool_opt '--new', 'Publish projects not published before.'
            bool_opt '--pending', 'Publish only pending.'
            bool_opt '--recache', 'Rewrite instances cache.'
            bool_opt '--run', 'Confirm publishing.'
            arg_opt '-s', '--stereotype', 'Publish only for stereotype <stereotype>.'
            pos_arg :instance_path, repeat: true, optional: true
          end

          def run
            ::EacLauncher::Context.current.recache = parsed.recache?
            build_publish_options
            instances.each do |i|
              next unless i.options.publishable?

              i.send(instance_method)
            end
          end

          private

          def dry_run?
            parsed.dry_run?
          end

          def instance_method
            run? || dry_run? ? 'publish_run' : 'publish_check'
          end

          def build_publish_options
            ::EacLauncher::Context.current.publish_options = publish_options
          end

          def publish_options
            { new: parsed.new?, stereotype: parsed.stereotype?, confirm: run? }
          end

          def run?
            parsed.run? && !dry_run?
          end
        end
      end
    end
  end
end
