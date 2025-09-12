# frozen_string_literal: true

module Avm
  module Tools
    module RunnerWith
      module InstanceDataDump
        common_concern do
          enable_simple_cache
          runner_definition do
            bool_opt '-w', '--rewrite', 'Forces dump overwrite.'
            pos_arg :dump_path, optional: true
          end

          set_callback :run, :after do
            success("Dump path: \"#{dump_path}\"")
            dump_path
          end
        end

        include ::Avm::Tools::RunnerWith::InstanceDataPerformer

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
          r = super.overwrite(parsed.rewrite?)
          parsed.dump_path.if_present(r) { |v| r.target_path(v.to_pathname) }
        end

        # @return [Pathname]
        def dump_path
          data_performer.target_path
        end

        def default_dump_path
          data_performer.default_dump_path
        end
      end
    end
  end
end
