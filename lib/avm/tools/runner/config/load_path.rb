# frozen_string_literal: true

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
            config_nodes.each { |config_node| run_show(config_node) }
            run_add
          end

          private

          # @return [[EacCli::Config]]
          def root_config_node
            ::EacConfig::Node.context.current
          end

          def config_nodes
            ::EacRubyUtils::RecursiveBuilder.new(root_config_node, &:self_loaded_nodes).result
          end

          def run_add
            parsed.push.if_present do |v|
              infov 'Path to add', v
              root_config_node.write_node.load_path.push(v)
              success 'Path included'
            end
          end

          def run_show(config_node)
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
