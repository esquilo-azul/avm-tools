# frozen_string_literal: true

require 'eac_docker/images/base'
require 'eac_docker/images/coded'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/fs/temp'
require 'eac_templates/patches/object/template'

module EacDocker
  module Images
    class Templatized < ::EacDocker::Images::Base
      enable_immutable
      immutable_accessor :tag
      attr_reader :provide_dir

      def id
        tag
      end

      def provide
        ::EacRubyUtils::Fs::Temp.on_directory do |provide_dir|
          begin
            self.provide_dir = provide_dir
            template.apply(self, provide_dir)
            coded_image(provide_dir).tag(tag).provide
          ensure
            self.provide_dir = nil
          end
        end
      end

      def coded_image(provide_dir)
        ::EacDocker::Images::Coded.new(provide_dir)
      end

      private

      attr_writer :provide_dir
    end
  end
end
