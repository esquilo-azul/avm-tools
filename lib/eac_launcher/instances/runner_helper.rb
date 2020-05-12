# frozen_string_literal: true

require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/console/speaker'

module EacLauncher
  module Instances
    class RunnerHelper < ::EacRubyUtils::Console::DocoptRunner
      include ::EacRubyUtils::Console::Speaker

      def context
        @context ||= ::EacLauncher::Context.current
      end

      def find_instances(instance_name)
        context.instances.select { |instance| instance_match?(instance, instance_name) }
      end

      def instance_match?(instance, instance_name)
        ::File.fnmatch?(instance_name, instance.name)
      end

      def instances
        if options['--all']
          context.instances
        elsif options['--pending']
          context.pending_instances
        else
          options['<instance_path>'].flat_map { |p| find_instances(p) }
        end
      end

      def instance_stereotypes(instance)
        instance.stereotypes.map(&:stereotype_name_in_color).join(', ')
      end

      def instance_label(instance)
        "#{instance.name} [#{instance_stereotypes(instance)}]"
      end
    end
  end
end
