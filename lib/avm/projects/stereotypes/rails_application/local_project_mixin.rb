# frozen_string_literal: true

require 'avm/projects/stereotypes/ruby_gem/local_project_mixin'
require 'eac_ruby_utils/core_ext'

module Avm
  module Projects
    module Stereotypes
      class RailsApplication
        module LocalProjectMixin
          common_concern do
            include ::Avm::Projects::Stereotypes::RubyGem::LocalProjectMixin
          end
        end
      end
    end
  end
end
