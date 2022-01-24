# frozen_string_literal: true

require 'eac_fs/contexts'

class Module
  ::EacFs::Contexts::TYPES.each do |type|
    method_name = "fs_#{type}"
    class_eval <<~CODE, __FILE__, __LINE__ + 1
      # @return [EacFs::StorageTree]
      def #{method_name}
        ::EacFs::Contexts.#{type}.current.child('#{method_name}', *name.split('::'))
      end
    CODE
  end
end
