# frozen_string_literal: true

require 'avm/fs_cache'
require 'eac_ruby_utils/core_ext'

module Avm
  class CachedDownload
    attr_reader :url, :fs_cache

    def initialize(url, parent_fs_cache = nil)
      @url = url
      @fs_cache = (parent_fs_cache || ::Avm.fs_cache).child(url.parameterize)
    end

    def assert
      download unless fs_cache.cached?
    end

    def download
      ::EacRubyUtils::Fs::Temp.on_file do |temp|
        download_to(temp)
        fs_cache.content_path.to_pathname.dirname.mkpath
        ::FileUtils.mv(temp.to_path, fs_cache.content_path)
      end
    end

    def path
      @path ||= fs_cache.content_path.to_pathname
    end

    private

    def download_to(local_file)
      ::URI.parse(url).open do |remote|
        local_file.open('wb') { |handle| handle.write(remote.read) }
      end
    end
  end
end
