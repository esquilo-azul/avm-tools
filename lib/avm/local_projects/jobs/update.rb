# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module LocalProjects
    module Jobs
      class Update
        enable_console_speaker
        common_constructor :instance

        def run
          instance.stereotypes.each { |stereotype| run_stereotype(stereotype) }
        end

        private

        def run_stereotype(stereotype)
          if stereotype.update_class.present?
            puts stereotype.label + ': update class found. Running...'
            stereotype.update_class.new(instance).run
          else
            puts stereotype.label + ': update class not found'
          end
        end
      end
    end
  end
end
