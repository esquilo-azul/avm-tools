# frozen_string_literal: true

require 'avm/apps/sources/configuration'
require 'avm/launcher/paths/real'
require 'eac_ruby_utils/core_ext'
require 'avm/projects/stereotypes'
require 'i18n'

module Avm
  class AppSrc
    enable_simple_cache
    common_constructor :path do
      self.path = path.to_pathname
      source_stereotypes_mixins
    end

    delegate :to_s, to: :path

    def locale
      configuration.if_present(&:locale) || ::I18n.default_locale
    end

    # Backward compatibility with [Avm::Launcher::Paths::Logical].
    # @return [Avm::Launcher::Paths::Real].
    def real
      ::Avm::Launcher::Paths::Real.new(path.to_path)
    end

    def run_job(job, job_args = [])
      stereotypes.each { |stereotype| run_stereotype_job(stereotype, job, job_args) }
    end

    private

    # @return [Avm::Apps::Sources::Configuration]
    def configuration_uncached
      ::Avm::Apps::Sources::Configuration.find_in_path(path)
    end

    def run_stereotype_job(stereotype, job, job_args)
      job_class_method = "#{job}_class"
      if stereotype.send(job_class_method).present?
        puts stereotype.label + ": #{job} class found. Running..."
        stereotype.send(job_class_method).new(self, *job_args).run
      else
        puts stereotype.label + ": #{job} class not found"
      end
    end

    def stereotypes_uncached
      ::Avm::Projects::Stereotypes.list.select { |s| s.match?(self) }
    end

    def source_stereotypes_mixins
      stereotypes.each do |s|
        s.local_project_mixin_module.if_present { |v| singleton_class.include(v) }
      end
    end
  end
end
