# frozen_string_literal: true

require 'avm/instances/entry'
require 'avm/instances/entry_keys'

module Avm
  module Instances
    class Base
      module AutoValues
        module Mailer
          ::Avm::Instances::EntryKeys.all.select { |c| c.to_s.start_with?('mailer.') }
                                     .reject { |c| c == ::Avm::Instances::EntryKeys::MAILER_ID }
                                     .each do |mailer_key|
            define_method ::Avm::Instances::Entry.auto_value_method_name(mailer_key) do
              mailer_auto_common(mailer_key)
            end
          end

          def auto_mailer_id
            inherited_entry_value(::Avm::Instances::EntryKeys::HOST_ID,
                                  ::Avm::Instances::EntryKeys::MAILER_ID) ||
              read_entry_optional(::Avm::Instances::EntryKeys::HOST_ID)
          end

          private

          def mailer_auto_common(mailer_key)
            inherited_entry_value(::Avm::Instances::EntryKeys::MAILER_ID, mailer_key)
          end
        end
      end
    end
  end
end
