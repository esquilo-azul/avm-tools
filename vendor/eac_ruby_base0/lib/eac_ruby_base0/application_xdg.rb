# frozen_string_literal: true

module EacRubyBase0
  # https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
  class ApplicationXdg
    class << self
      # @return [Pathname]
      def user_home_dir_from_env
        ENV.fetch('HOME').to_pathname
      end
    end

    DIRECTORIES = { cache: '.cache', config: '.config', data: '.local/share',
                    state: '.local/state' }.freeze

    common_constructor :app_name, :user_home_dir, default: [nil] do
      self.user_home_dir ||= self.class.user_home_dir_from_env
    end

    DIRECTORIES.each do |item, subpath|
      xdg_env_method_name = "#{item}_xdg_env"

      define_method xdg_env_method_name do
        ENV["XDG_#{item.upcase}_HOME"].if_present(&:to_pathname)
      end

      define_method "#{item}_dir" do
        (send(xdg_env_method_name) || user_home_dir.join(subpath)).join(app_name)
      end
    end
  end
end
