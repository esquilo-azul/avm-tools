# frozen_string_literal: true

require 'avm/instances/runner'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class Data
          class Dump
            runner_with :help, :include_exclude, :instance_data_dump do
              desc 'Dump utility for instance.'
            end
          end
        end
      end
    end
  end
end
