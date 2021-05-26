# frozen_string_literal: true

require 'ruby-progressbar'
require 'avm/launcher/instances/base'

module Avm
  module Launcher
    class Context
      class InstanceDiscovery
        attr_reader :instances

        def initialize(context)
          @context = context
          @progress = ::ProgressBar.create(title: 'Instance discovery', total: 1)
          @instances = path_instances(@context.root, nil)
        ensure
          @progress&.finish
        end

        private

        def path_instances(path, parent_instance)
          update_progress_format(path)
          on_rescued_path_instances(path) do |r|
            if path.project?
              parent_instance = ::Avm::Launcher::Instances::Base.instanciate(path, parent_instance)
              r << path
            end
            children = path.children
            update_progress_count(children)
            r.concat(children.flat_map { |c| path_instances(c, parent_instance) })
          end
        end

        def on_rescued_path_instances(path)
          r = []
          begin
            yield(r) if path.included?
          rescue StandardError => e
            warn("#{path}: #{e}")
          end
          r
        end

        def update_progress_format(path)
          @progress.format = "%t (Paths: %c/%C, Current: #{path.logical}) |%B| %a"
        end

        def update_progress_count(children)
          @progress.total += children.count
          @progress.increment
        end
      end
    end
  end
end
