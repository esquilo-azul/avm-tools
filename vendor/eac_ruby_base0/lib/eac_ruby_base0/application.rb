# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRubyBase0
  class Application
    enable_simple_cache
    common_constructor :gemspec_dir do
      self.gemspec_dir = gemspec_dir.to_pathname
    end

    delegate :version, to: :self_gem

    def all_gems
      vendor_gems + [self_gem]
    end

    def vendor_dir
      gemspec_dir.join('vendor')
    end

    private

    def self_gem_uncached
      ::EacRubyGemsUtils::Gem.new(gemspec_dir)
    end

    def vendor_gems_uncached
      r = []
      vendor_dir.children.each do |c|
        vgem = ::EacRubyGemsUtils::Gem.new(c)
        r << vgem if vgem.gemfile_path.exist?
      end
      r
    end
  end
end
