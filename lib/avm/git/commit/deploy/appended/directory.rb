# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'avm/git/commit/deploy/appended/base'

module Avm
  module Git
    class Commit
      class Deploy
        module Appended
          class Directory < ::Avm::Git::Commit::Deploy::Appended::Base
            attr_reader :source_path

            def initialize(deploy, source_path)
              super(deploy)
              @source_path = source_path
            end

            def copy_to_build_dir
              raise 'Variables source not set' if deploy.variables_source.blank?

              ::EacRubyUtils::Templates::Directory.new(source_path).apply(
                deploy.variables_source,
                deploy.build_dir
              )
            end
          end
        end
      end
    end
  end
end
