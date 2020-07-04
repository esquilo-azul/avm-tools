# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/git/commit/deploy/appended/base'

module Avm
  module Git
    class Commit
      class Deploy
        module Appended
          class FileContent < ::Avm::Git::Commit::Deploy::Appended::Base
            attr_reader :target_path, :content

            def initialize(deploy, target_path, content)
              super(deploy)
              @target_path = target_path
              @content = content
            end

            def copy_to_build_dir
              deploy.build_dir.to_pathname.join(target_path).write(content)
            end
          end
        end
      end
    end
  end
end
