# frozen_string_literal: true

require 'avm/sources/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacGenericBase0
    module Sources
      class Base < ::Avm::Sources::Base
        module VersionBump
          def after_sub_version_bump_do_changes
            # Do nothing
          end

          # @return [Avm::Scms::Commit, nil]
          def version_bump(target_version)
            scm.commit_if_change(version_bump_commit_message(target_version)) do
              version_bump_do_changes(target_version)
              parent.if_present(&:after_sub_version_bump_do_changes)
            end
          end

          # @return [String]
          def version_bump_commit_message(target_version)
            i18n_translate(__method__, version: target_version, __locale: locale)
          end

          def version_bump_do_changes(_target_version)
            raise_abstract_method(__METHOD__)
          end
        end
      end
    end
  end
end
