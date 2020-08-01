# frozen_string_literal: true

require 'avm/eac_redmine_base0/data_unit'
require 'avm/stereotypes/eac_ubuntu_base0/docker_image'
require 'avm/stereotypes/eac_webapp_base0/instance'
require 'avm/stereotypes/rails/instance'

module Avm
  module EacRedmineBase0
    class Instance < ::Avm::Stereotypes::EacWebappBase0::Instance
      include ::Avm::Stereotypes::Rails::Instance

      FILES_UNITS = { files: 'files' }.freeze

      def docker_image_class
        ::Avm::Stereotypes::EacUbuntuBase0::DockerImage
      end

      def docker_run_arguments
        [
          '--volume', "#{read_entry(:fs_path)}:/home/myuser/eac_redmine_base0",
          '--publish', "#{read_entry(:ssh_port)}:22",
          '--publish', "#{read_entry(:http_port)}:80",
          '--publish', "#{read_entry(:https_port)}:443"
        ]
      end

      def data_package
        @data_package ||= ::Avm::Data::Instance::Package.new(
          self,
          units: {
            all: ::Avm::EacRedmineBase0::DataUnit.new(self)
          }
        )
      end
    end
  end
end