# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Application
        class Info
          APPLICATION_PROPERTIES = {
            id: 'ID',
            name: 'Name',
            organization: 'Organization',
            scm: 'SCM',
            stereotype: 'Stereotype'
          }.freeze

          runner_with :help, :output_item do
            desc 'Show information about application.'
          end

          def run
            run_output
          end

          # @return [Hash]
          def item_hash
            APPLICATION_PROPERTIES.inject({}) do |a, e|
              a.merge(e.last => application.send(e.first).to_s)
            end
          end
        end
      end
    end
  end
end
