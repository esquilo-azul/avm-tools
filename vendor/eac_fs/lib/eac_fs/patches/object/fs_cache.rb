# frozen_string_literal: true

require 'eac_fs/patches/module/fs_cache'

class Object
  # @return [EacFs::Cache]
  def fs_cache
    self.class.fs_cache
  end
end
