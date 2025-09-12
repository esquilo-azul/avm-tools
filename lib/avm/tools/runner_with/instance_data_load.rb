# frozen_string_literal: true

module Avm
  module Tools
    module RunnerWith
      module InstanceDataLoad
        common_concern do
          enable_simple_cache

          runner_definition do
            arg_opt '-S', '--source-instance', 'Informa a instância a ser extraída o dump.'
            bool_opt '-w', '--rewrite'
            pos_arg :dump_path, optional: true
          end

          set_callback :run, :after do
            success("Dump loaded from \"#{dump_path}\"")
          end
        end

        include ::Avm::Tools::RunnerWith::InstanceDataPerformer

        # @return [Class]
        def data_performer_class
          ::Avm::Data::Loader
        end

        private

        # @return [Avm::Data::Loader]
        def data_performer_uncached
          super.source_path(dump_path)
        end

        # @return [Pathname]
        def dump_path_uncached
          return parsed.dump_path.to_pathname if parsed.dump_path.present?
          return source_instance_dump_path if parsed.source_instance.present?

          fatal_error "Dump path not set (Options: #{parsed})"
        end

        # @return [Avm::Instances::Base]
        def source_instance
          runner_context.call(:instance).class.by_id(parsed.source_instance)
        end

        # @return [Avm::Data::Dumper]
        def source_instance_dumper
          data_performer_set_includes_excludes(
            ::Avm::Data::Dumper.new(source_instance_data_owner).overwrite(parsed.rewrite?)
          )
        end

        # @return [Pathname]
        def source_instance_dump_path
          r = source_instance_dumper
          r.perform
          r.target_path
        end
      end
    end
  end
end
