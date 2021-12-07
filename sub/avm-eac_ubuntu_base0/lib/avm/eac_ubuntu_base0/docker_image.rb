# frozen_string_literal: true

require 'avm/docker/image'
require 'eac_templates/from_all_gems'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacUbuntuBase0
    class DockerImage < ::Avm::Docker::Image
      USER_NAME = 'myuser'

      def stereotype_tag
        'eac_ubuntu_base0'
      end

      def user_home
        ::File.join('/home', user_name)
      end

      def user_name
        USER_NAME
      end

      def user_password
        user_name
      end
    end
  end
end
