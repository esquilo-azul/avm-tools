# frozen_string_literal: true

require 'avm/stereotypes/eac_webapp_base0/instance'

module Avm
  module Stereotypes
    module EacWordpressBase0
      class Instance < ::Avm::Stereotypes::EacWebappBase0::Instance
        FILES_UNITS = { uploads: 'wp-content/uploads', themes: 'wp-content/themes' }.freeze

        def database_unit
          self_instance = self
          super.after_load do
            info 'Fixing web addresses...'
            run_sql(<<~SQL)
              update wp_options
              set option_value = '#{self_instance.read_entry('url')}'
              where option_name in ('siteurl', 'home')
            SQL
          end
        end
      end
    end
  end
end
