# frozen_string_literal: true

require 'avm/fs_cache'
require 'avm/ruby/bundler/incompatible_parser'
require 'eac_ruby_base0/core_ext'

module Avm
  module Tools
    class Runner
      class AppSrc
        class Ruby
          class Bundler
            class Incompatible
              runner_with :help do
                desc 'Identify incompatible gems in a "Gemfile.lock" file.'
                bool_opt '-l', '--last', 'Process the last \"bundle update\" result.'
              end

              def run
                infov 'Cache path', fs_cache.content_path
                infov 'Cached?', fs_cache.cached?
                parser.gems_in_conflict.each do |gem_in_conflict|
                  print_gem_in_conflict(gem_in_conflict)
                end
              end

              private

              def bundle_update
                infom 'Running "bundle update"...'
                instance.ruby_gem.bundle('update').execute[:stdout]
              end

              def content_path
                fs_cache.write(bundle_update) unless fs_cache.cached? && parsed.last?
                fs_cache.content_path
              end

              def fs_cache_uncached
                ::Avm.fs_cache.child(self.class.name.variableize)
                     .child(instance.path.to_s.variableize)
              end

              def gem_title(gem_in_conflict)
                gem_in_conflict.gem_name
              end

              def instance
                runner_context.call(:instance)
              end

              def parser_uncached
                ::Avm::Ruby::Bundler::IncompatibleParser.new(content_path)
              end

              def print_gem_in_conflict(gem_in_conflict)
                infov 'Gem', gem_title(gem_in_conflict)
                gem_in_conflict.versions_requirements.each do |requirement|
                  print_requirement(requirement)
                end
              end

              def print_requirement(req)
                infov '  ' + requirement_title(req), requirement_value(req)
              end

              def requirement_stack(req)
                req.stack.map { |d| "#{d.gem_name} (#{d.version})" }.join(' > '.green)
              end

              def requirement_title(req)
                req.requirements_source.if_present('*')
              end

              def requirement_value(req)
                requirement_stack(req)
              end
            end
          end
        end
      end
    end
  end
end
