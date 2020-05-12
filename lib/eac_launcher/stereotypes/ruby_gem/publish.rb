# frozen_string_literal: true

require 'curb'
require 'json'
require 'eac_ruby_utils/simple_cache'
require 'rubygems'
require 'eac_ruby_utils/console/speaker'
require 'eac_launcher/publish/base'
require 'eac_launcher/publish/check_result'
require 'eac_launcher/ruby/gem'

module EacLauncher
  module Stereotypes
    class RubyGem
      class Publish < ::EacLauncher::Publish::Base
        include ::EacRubyUtils::SimpleCache
        include ::EacRubyUtils::Console::Speaker

        protected

        def internal_check
          gem_published? ? internal_check_gem_published : internal_check_gem_unpublished
        end

        private

        def internal_check_gem_published
          if version_published?
            outdated_version? ? outdated_version_check_result : version_published_check_result
          else
            version_unpublished_check_result
          end
        end

        def internal_check_gem_unpublished
          if new_gem_allowed?
            version_unpublished_check_result
          else
            new_gem_disallowed_check_result
          end
        end

        def new_gem_disallowed_check_result
          ::EacLauncher::Publish::CheckResult.blocked(
            "#{gem_spec.full_name} does not exist in RubyGems"
          )
        end

        def version_published_check_result
          ::EacLauncher::Publish::CheckResult.updated("#{gem_spec.full_name} already pushed")
        end

        def outdated_version_check_result
          ::EacLauncher::Publish::CheckResult.outdated(
            "#{gem_spec.full_name} is outdated (Max: #{gem_version_max})"
          )
        end

        def version_unpublished_check_result
          ::EacLauncher::Publish::CheckResult.pending("#{gem_spec.full_name} not found " \
              'in RubyGems')
        end

        def source_uncached
          instance.warped
        end

        def gem_spec_uncached
          ::EacLauncher::Stereotypes::RubyGem.load_gemspec(gemspec)
        end

        def gem_build_uncached
          ::EacLauncher::Ruby::Gem::Build.new(source)
        end

        def publish
          gem_build.build
          push_gem
        ensure
          gem_build.close
        end

        def new_gem_allowed?
          ::EacLauncher::Context.current.publish_options[:new]
        end

        def gem_published?
          gem_versions.any?
        end

        def version_published?
          gem_versions.any? { |v| v['number'] == gem_spec.version }
        end

        def outdated_version?
          gem_version_max.present? && ::Gem::Version.new(gem_spec.version) < gem_version_max
        end

        def gem_versions_uncached
          http = Curl.get("https://rubygems.org/api/v1/versions/#{gem_spec.name}.json")
          return JSON.parse!(http.body_str) if /\A2/ =~ http.status
          return [] if /\A4/ =~ http.status

          raise "#{http} code error: #{http.status}"
        end

        def gem_version_max_uncached
          gem_versions.map { |v| ::Gem::Version.new(v['number']) }.max
        end

        def push_gem
          info("Pushing gem #{gem_spec}...")
          command = ['gem', 'push', gem_build.output_file]
          unless ::EacLauncher::Context.current.publish_options[:confirm]
            command = %w[echo] + command + %w[(Dry-run)]
          end
          EacRubyUtils::Envs.local.command(command).system
          info('Pushed!')
        end

        def gemspec_uncached
          source.find_file_with_extension('.gemspec')
        end
      end
    end
  end
end
