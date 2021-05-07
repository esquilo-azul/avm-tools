# frozen_string_literal: true

require 'avm/self'
require 'eac_ruby_utils/core_ext'

class Object
  class << self
    def avm_fs_cache
      ::Avm::Self.application.fs_cache.child(name.variableize)
    end
  end

  def avm_fs_cache
    self.class.avm_fs_cache.child(avm_fs_cache_object_id)
  end
end
