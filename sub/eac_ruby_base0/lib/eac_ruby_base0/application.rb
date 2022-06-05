# frozen_string_literal: true

require 'eac_cli/config'
require 'eac_config/envvars_node'
require 'eac_config/yaml_file_node'
require 'eac_fs/contexts'
require 'eac_fs/storage_tree'
require 'eac_ruby_base0/application_xdg'
require 'eac_ruby_gems_utils/gem'
require 'eac_ruby_utils/core_ext'

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
      sub_gems + [self_gem]
    end

    # @return [EacCli::Config]
    def build_config(path = nil)
      envvar_node = ::EacConfig::EnvvarsNode.new
      file_node = ::EacConfig::YamlFileNode.new(path || config_default_path)
      envvar_node.load_path.push(file_node.url)
      envvar_node.write_node = file_node
      ::EacCli::Config.new(envvar_node)
    end

    # @return [EacCli::Config]
    def config_default_path
      config_dir.join('eac_config.yaml')
    end

    ::EacRubyBase0::ApplicationXdg::DIRECTORIES.each_key do |item|
      delegate "#{item}_xdg_env", "#{item}_dir", to: :app_xdg
    end

    ::EacFs::Contexts::TYPES.each do |type|
      class_eval <<CODE, __FILE__, __LINE__ + 1
  # @return [EacFs::StorageTree]
  def self_fs_#{type}
    @self_fs_#{type} ||= ::EacFs::StorageTree.new(#{type}_dir.join('eac_fs'))
  end
CODE
    end

    def home_dir
      app_xdg.user_home_dir
    end

    def name
      options[OPTION_NAME] || self_gem.name
    end

    def vendor_dir
      gemspec_dir.join('sub')
    end

    private

    def app_xdg_uncached
      ::EacRubyBase0::ApplicationXdg.new(name, options[OPTION_HOME_DIR])
    end

    def self_gem_uncached
      ::EacRubyGemsUtils::Gem.new(gemspec_dir)
    end

    def sub_gems_uncached
      r = []
      vendor_dir.children.each do |c|
        vgem = ::EacRubyGemsUtils::Gem.new(c)
        r << vgem if vgem.gemfile_path.exist?
      end
      r
    end
  end
end
