# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/deploy'

module Avm
  module Stereotypes
    module EacRailsBase0
      class Deploy < ::Avm::Stereotypes::EacWebappBase0::Deploy
        set_callback :assert_instance_branch, :after do
          bundle_install
          assert_database
          database_migrate
          compile_assets
        end

        def assert_database
          infom 'Asserting database...'
          instance.rake('db:create').system!
        end

        def bundle_install
          infom 'Running "bundle install"...'
          instance.bundle('install').system!
        end

        def compile_assets
          infom 'Compiling assets...'
          instance.rake('assets:clean', 'assets:precompile').system!
        end

        def database_migrate
          infom 'Running database migrations...'
          instance.rake('db:migrate').system!
        end
      end
    end
  end
end
