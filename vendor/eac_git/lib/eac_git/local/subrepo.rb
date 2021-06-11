# frozen_string_literal: true

require 'eac_git/remote'
require 'eac_ruby_utils/core_ext'

module EacGit
  class Local
    # A git-subrepo (https://github.com/ingydotnet/git-subrepo) in a [EacGit::Local].
    class Subrepo
      require_sub __FILE__
      enable_simple_cache

      common_constructor :local, :subpath do
        self.subpath = subpath.to_pathname
        local.raise_error "Config file \"#{config_absolute_path}\" not found" unless
          config_absolute_path.file?
      end

      def command(subrepo_subcommand, *subrepo_subcommand_args)
        local.command('subrepo', subrepo_subcommand, subpath.to_path,
                      *subrepo_subcommand_args)
      end

      delegate(*::EacGit::Local::Subrepo::Config::MAPPING.keys, to: :config)

      def write_config
        config_absolute_path.write(config.to_content)
      end

      private

      def config_uncached
        ::EacGit::Local::Subrepo::Config.from_file(config_absolute_path)
      end

      def config_absolute_path_uncached
        config_relative_path.expand_path(local.root_path)
      end

      def config_relative_path_uncached
        subpath.join('.gitrepo')
      end

      def remote_uncached
        ::EacGit::Remote.new(remote_uri)
      end
    end
  end
end
