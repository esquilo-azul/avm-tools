# frozen_string_literal: true

require 'eac_ruby_utils/filesystem_cache'

module Avm
  class << self
    def fs_cache
      @fs_cache ||= ::EacRubyUtils::FilesystemCache.new(ENV['HOME'], '.cache', 'avm')
    end
  end
end
