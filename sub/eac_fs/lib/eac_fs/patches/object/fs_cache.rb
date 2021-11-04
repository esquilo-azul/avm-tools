# frozen_string_literal: true

require 'eac_fs/patches/module/fs_cache'

class Object
  # @return [EacFs::Cache]
  def fs_cache
    oid = fs_cache_object_id
    oid = [oid.to_s] unless oid.is_a?(::Enumerable)
    oid.inject(self.class.fs_cache) { |a, e| a.child(e.to_s) }
  end

  # @return [String, Array<String>]
  def fs_cache_object_id
    raise 'Abstract method hit'
  end
end
