# frozen_string_literal: true

require 'avm/eac_redmine_base0/core_update'
require 'eac_cli/core_ext'

module Avm
  module Tools
    class Runner
      class EacRedmineBase0 < ::Avm::EacRailsBase1::Runner
        class CoreUpdate
          runner_with :help do
            arg_opt '-u', '--url', 'Core\'s package URL.'
            arg_opt '-v', '--version', 'Core\'s version.'
            desc 'Update instance\' core.'
          end

          def run
            start_banner
            validate
            update
          end

          private

          def start_banner
            infov 'URL', url
            infov 'Version', version
          end

          def update
            ::Avm::EacRedmineBase0::CoreUpdate.new(runner_context.call(:instance), version, url).run
          end

          def url
            parsed.url || url_by_version
          end

          def url_by_version
            parsed.version.if_present do |v|
              "https://www.redmine.org/releases/redmine-#{v}.tar.gz"
            end
          end

          def validate
            %w[url version].each do |attr|
              fatal_error "\"#{attr}\" is blank. See avaiable options." if send(attr).blank?
            end
          end

          def version
            parsed.version || version_by_url
          end

          def version_by_url
            parsed.url.if_present do |v|
              /(\d+.\d+.\d+)/.if_match(v, false) { |m| m[1] }
            end
          end
        end
      end
    end
  end
end
