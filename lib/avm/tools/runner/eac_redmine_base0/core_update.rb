# frozen_string_literal: true

require 'avm/eac_redmine_base0/core_update'
require 'eac_cli/default_runner'
require 'eac_ruby_utils/console/docopt_runner'
require 'eac_ruby_utils/core_ext'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRedmineBase0 < ::EacRubyUtils::Console::DocoptRunner
        class CoreUpdate < ::EacRubyUtils::Console::DocoptRunner
          include ::EacCli::DefaultRunner

          runner_definition do
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
            ::Avm::EacRedmineBase0::CoreUpdate.new(context(:instance), version, url).run
          end

          def url
            options.fetch('--url') || url_by_version
          end

          def url_by_version
            options.fetch('--version').if_present do |v|
              "https://www.redmine.org/releases/redmine-#{v}.tar.gz"
            end
          end

          def validate
            %w[url version].each do |attr|
              fatal_error "\"#{attr}\" is blank. See avaiable options." if send(attr).blank?
            end
          end

          def version
            options.fetch('--version') || version_by_url
          end

          def version_by_url
            options.fetch('--url').if_present do |v|
              /(\d+.\d+.\d+)/.if_match(v, false) { |m| m[1] }
            end
          end
        end
      end
    end
  end
end
