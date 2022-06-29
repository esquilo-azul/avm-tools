# frozen_string_literal: true

require 'avm/eac_rails_base1/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRedmineBase0
    module Sources
      class Base < ::Avm::EacRailsBase1::Sources::Base
        REDMINE_LIB_SUBPATH = 'lib/redmine.rb'
        SUBS_INCLUDE_PATHS_DEFAULT = ['plugins/*'].freeze

        def redmine_lib_path
          path.join(REDMINE_LIB_SUBPATH)
        end

        def subs_include_paths_default
          SUBS_INCLUDE_PATHS_DEFAULT
        end

        def valid?
          super && redmine_lib_path.exist?
        end
      end
    end
  end
end
