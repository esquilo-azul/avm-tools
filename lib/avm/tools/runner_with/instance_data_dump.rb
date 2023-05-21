# frozen_string_literal: true

require 'avm/data/dumper'
require 'eac_cli/core_ext'
require 'avm/tools/runner_with/instance_data_performer'

module Avm
  module Tools
    module RunnerWith
      module InstanceDataDump
        common_concern do
          enable_simple_cache
          include ::Avm::Tools::RunnerWith::InstanceDataPerformer

          runner_definition do
            bool_opt '-w', '--rewrite', 'Forces dump overwrite.'
            pos_arg :dump_path, optional: true
          end

          set_callback :run, :after do
            success("Dump path: \"#{dump_path}\"")
            dump_path
          end
        end

        DUMP_EXPIRE_TIME = 1.day
        NO_DUMP_MESSAGE = 'Dump "%s" already exist and rewrite options was no setted nor ' \
          'dump was expired.'

        # @return [Class]
        def data_performer_class
          ::Avm::Data::Dumper
        end

        # @return [String]
        def help_extra_text
          "Default dump path: \"#{default_dump_path}\""
        end

        private

        # @return [Avm::Data::Dumper]
        def data_performer_uncached
          super.existing(dump_existing)
        end

        # @return [Pathname]
        def dump_path
          (parsed.dump_path || default_dump_path).to_pathname
        end

        def default_dump_path
          data_performer.default_dump_path
        end

        def dump_existing
          if parsed.rewrite?
            ::Avm::Data::Package::Dump::EXISTING_ROTATE
          else
            ::Avm::Data::Package::Dump::EXISTING_ROTATE_EXPIRED
          end
        end
      end
    end
  end
end
