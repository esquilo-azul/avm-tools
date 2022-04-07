# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/eac_postgresql_base0/instance_with'
require 'avm/data/instance/files_unit'
require 'avm/data/instance/package'
require 'avm/eac_webapp_base0/deploy/file_unit'
require 'avm/eac_ubuntu_base0/instances/base'

module Avm
  module EacWebappBase0
    class Instance < ::Avm::Instances::Base
      require_sub __FILE__
      include ::Avm::EacPostgresqlBase0::InstanceWith
      enable_simple_cache

      FILES_UNITS = [].freeze

      def stereotype_name
        self.class.name.desconstantize.demodulize
      end

      def data_dump(argv = [])
        run_subcommand(::Avm::Tools::Runner::EacWordpressBase0::Data::Dump, argv)
      end

      def data_dump_runner_class
        "::Avm::Tools::Runner::#{stereotype_name}::Data::Dump".constantize
      end

      def run_subcommand(subcommand_class, argv)
        subcommand_class.create(
          argv: argv,
          parent: ::Avm::EacWebappBase0::Instance::SubcommandParent.new(self)
        ).run
      end

      def data_package
        @data_package ||= ::Avm::Data::Instance::Package.new(
          self, units: { database: database_unit }.merge(files_units)
        )
      end

      def database_unit
        pg.data_unit
      end

      private

      # @return [Avm::EacUbuntuBase0::Instances::Base]
      def platform_instance_uncached
        ::Avm::EacUbuntuBase0::Instances::Base.by_id(id)
      end

      def files_units
        self.class.const_get('FILES_UNITS').transform_values do |fs_path_subpath|
          ::Avm::Data::Instance::FilesUnit.new(self, fs_path_subpath)
        end
      end
    end
  end
end
