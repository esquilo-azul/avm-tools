# frozen_string_literal: true

require 'eac_fs/cache'

class Module
  # @return [EacFs::Cache]
  def fs_cache
    ::EacFs::Cache.context.current.child('fs_cache', *name.split('::'))
  end
end
