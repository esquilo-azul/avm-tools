# frozen_string_literal: true

require 'avm/sources/base'
require 'avm/sources/configuration'
require 'avm/launcher/paths/real'
require 'avm/projects/stereotype/job_comparator'
require 'eac_ruby_utils/core_ext'
require 'avm/projects/stereotypes'
require 'i18n'

module Avm
  module Tools
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
        stereotypes_jobs(job, job_args).each(&:run)
      end

      private

      def avm_instance_uncached
        ::Avm::Sources::Base.new(path)
      end

      # @return [Avm::Apps::Sources::Configuration]
      def configuration_uncached
        ::Avm::Sources::Configuration.find_in_path(path)
      end

      def stereotypes_jobs(job, job_args)
        job_class_method = "#{job}_class"
        r = []
        stereotypes.each do |stereotype|
          r << stereotype.send(job_class_method).new(self, *job_args) if
          stereotype.send(job_class_method).present?
        end
        r.sort { |a, b| ::Avm::Projects::Stereotype::JobComparator.new(a, b).result }
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
end
