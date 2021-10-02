# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'active_support/callbacks'

module Avm
  module Data
    class Unit
      include ::ActiveSupport::Callbacks

      define_callbacks :dump, :load
      enable_speaker

      %w[dump load].each do |action|
        method_name = "#{action}_command"
        class_eval <<~CODE, __FILE__, __LINE__ + 1
          # Should be overrided.
          # @return [EacRubyUtils::Envs::Command]
          def #{method_name}
            fail "\\"#{method_name}\\" is a abstract method. Override in #{singleton_class}."
          end
        CODE

        # Callbacks
        %w[before after].each do |callback|
          method = "#{callback}_#{action}"
          class_eval <<~CODE, __FILE__, __LINE__ + 1
            def self.#{method}(callback_method = nil, &block)
              if callback_method
                set_callback :#{action}, :#{callback}, callback_method
              else
                set_callback :#{action}, :#{callback}, &block
              end
              self
            end

            def #{method}(callback_method = nil, &block)
              singleton_class.#{method}(callback_method, &block)
              self
            end
          CODE
        end
      end

      def extension
        singleton_class.const_get('EXTENSION')
      rescue NameError
        ''
      end

      def name
        self.class
      end

      def load_from_directory(directory, identifier)
        load(unit_on_directory_path(directory, identifier))
      end

      def dump_to_directory(directory, identifier)
        dump(unit_on_directory_path(directory, identifier))
      end

      def dump(data_path)
        run_callbacks :dump do
          infom "Dumping unit \"#{name}\" to \"#{data_path}\"..."
          do_dump(data_path)
        end
      end

      def load(data_path)
        run_callbacks :load do
          infom "Loading unit \"#{name}\" from \"#{data_path}\"..."
          do_load(data_path)
        end
      end

      protected

      def do_dump(data_path)
        dump_command.execute!(output_file: data_path)
      end

      def do_load(data_path)
        load_command.execute!(input_file: data_path)
      end

      private

      def unit_on_directory_path(directory, identifier)
        ::File.join(directory, "#{identifier}#{extension}")
      end
    end
  end
end
