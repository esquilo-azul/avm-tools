# frozen_string_literal: true

require 'avm/self'
require 'avm/tools/core_ext'
require 'eac_config/node'

module Avm
  module Tools
    class Runner
      class Config
        class LoadPath
          runner_with :help do
            desc 'Manipulate include path.'
            arg_opt '-p', '--push', 'Add a path.'
          end

          def run
            run_show
            run_add
          end

          private

          # @return [[EacCli::Config]]
          def config_node
            ::EacConfig::Node.context.current
          end

          def run_add
            parsed.push.if_present do |v|
              infov 'Path to add', v
              config_node.load_path.push(v)
              success 'Path included'
            end
          end

          def run_show
            infov 'Configuration path', config_node.url
            infov 'Paths included', config_node.self_loaded_nodes.count
            config_node.self_loaded_nodes.each do |loaded_node|
              infov '  * ', loaded_node.url
            end
          end
        end
      end
    end
  end
end
