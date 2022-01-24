# frozen_string_literal: true

require 'eac_fs/contexts'
require 'eac_fs/patches/module/fs_cache'

class Object
  ::EacFs::Contexts::TYPES.each do |type|
    class_eval <<~CODE, __FILE__, __LINE__ + 1
      # @return [EacFs::StorageTree]
      def fs_#{type}
        oid = fs_object_id_by_type(:'#{type}')
        oid = [oid.to_s] unless oid.is_a?(::Enumerable)
        oid.inject(self.class.fs_#{type}) { |a, e| a.child(e.to_s) }
      end
    CODE
  end

  # @return [String, Array<String>]
  def fs_object_id
    raise 'Abstract method hit'
  end

  def fs_object_id_by_type(type)
    method = "fs_#{type}_object_id"
    respond_to?(method) ? send(method) : fs_object_id
  end
end
