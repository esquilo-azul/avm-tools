# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/stereotypes/postgresql/instance_with'
require 'avm/data/instance/files_unit'
require 'avm/data/instance/package'

module Avm
  module Stereotypes
    module EacWordpressBase0
      class Instance < ::Avm::Instances::Base
        include ::Avm::Stereotypes::Postgresql::InstanceWith

        FILES_UNITS = { uploads: 'wp-content/uploads', themes: 'wp-content/themes' }.freeze

        def data_dump(argv = [])
          run_subcommand(::Avm::Tools::Runner::EacWordpressBase0::Data::Dump, argv)
        end

        def run_subcommand(subcommand_class, argv)
          parent = ::OpenStruct.new(instance: self)
          subcommand_class.new(argv: argv, parent: parent).run
        end

        def data_package
          @data_package ||= ::Avm::Data::Instance::Package.new(
            self, units: { database: database_unit }.merge(files_units)
          )
        end

        def database_unit
          self_instance = self
          pg.data_unit.after_load do
            info 'Fixing web addresses...'
            run_sql(<<~SQL)
              update wp_options
              set option_value = '#{self_instance.read_entry('url')}'
              where option_name in ('siteurl', 'home')
            SQL
          end
        end

        private

        def files_units
          FILES_UNITS.map do |data_key, fs_path_subpath|
            [data_key, ::Avm::Data::Instance::FilesUnit.new(self, fs_path_subpath)]
          end.to_h
        end
      end
    end
  end
end
