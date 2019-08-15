# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/stereotypes/postgresql/instance_with'

module Avm
  module Stereotypes
    module EacWordpressBase0
      class Instance < ::Avm::Instances::Base
        include ::Avm::Stereotypes::Postgresql::InstanceWith

        def data_dump(argv = [])
          run_subcommand(::Avm::Tools::Runner::EacWordpressBase0::Data::Dump, argv)
        end

        def run_subcommand(subcommand_class, argv)
          parent = ::OpenStruct.new(instance: self)
          subcommand_class.new(argv: argv, parent: parent).run
        end
      end
    end
  end
end
