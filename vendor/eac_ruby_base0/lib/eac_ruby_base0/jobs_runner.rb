# frozen_string_literal: true

require 'eac_ruby_utils/console/speaker'
require 'eac_ruby_utils/settings_provider'

module EacRubyBase0
  module JobsRunner
    common_concern do
      include ::EacRubyUtils::Console::Speaker
      include ::EacRubyUtils::SettingsProvider
    end

    def run_job(job)
      return unless run_job?(job)

      infom "Running job \"#{job}\"..."
      send(job)
    end

    def run_job?(job)
      the_method = "run_#{job}?"
      respond_to?(the_method, true) ? send(the_method) : true
    end

    def run_jobs(*jobs)
      jobs = setting_value(:jobs) if jobs.empty?
      jobs.each { |job| run_job(job) }
      success 'Done'
    end
  end
end
