# frozen_string_literal: true

require 'eac_fs/patches/module/fs_cache'

class Object
  # @return [EacFs::Cache]
  def fs_cache
    self.class.fs_cache.child(fs_cache_object_id)
  end

  # @return [String]
  def fs_cache_object_id
    raise 'Abstract method hit'
  end
end
