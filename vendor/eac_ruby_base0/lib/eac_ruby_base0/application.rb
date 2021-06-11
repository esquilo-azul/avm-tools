# frozen_string_literal: true

require 'eac_ruby_base0/application_xdg'
require 'eac_ruby_gems_utils/gem'
require 'eac_ruby_utils/core_ext'
require 'eac_ruby_utils/filesystem_cache'

module EacRubyBase0
  class Application
    enable_simple_cache
    enable_listable
    lists.add_symbol :option, :name, :home_dir

    common_constructor :gemspec_dir, :options, default: [{}] do
      self.gemspec_dir = gemspec_dir.to_pathname
      self.options = options.symbolize_keys.assert_valid_keys(self.class.lists.option.values).freeze
    end

    delegate :version, to: :self_gem

    def all_gems
      vendor_gems + [self_gem]
    end

    ::EacRubyBase0::ApplicationXdg::DIRECTORIES.each_key do |item|
      delegate "#{item}_xdg_env", "#{item}_dir", to: :app_xdg
    end

    def fs_cache
      @fs_cache ||= ::EacRubyUtils::FilesystemCache.new(
        cache_dir.join(::EacRubyUtils::FilesystemCache.name.parameterize)
      )
    end

    def home_dir
      app_xdg.user_home_dir
    end

    def name
      options[OPTION_NAME] || self_gem.name
    end

    def vendor_dir
      gemspec_dir.join('vendor')
    end

    private

    def app_xdg_uncached
      ::EacRubyBase0::ApplicationXdg.new(name, options[OPTION_HOME_DIR])
    end

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
