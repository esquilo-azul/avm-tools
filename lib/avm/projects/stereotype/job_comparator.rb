# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Projects
    module Stereotype
      class JobComparator
        common_constructor :job1, :job2

        def result
          return -1 if run_before?(job1, job2)
          return 1 if run_before?(job2, job1)

          job1.object_id <=> job2.class.name
        end

        private

        def run_before?(a_job, other_job)
          return false unless a_job.respond_to?(:run_before)

          a_job.run_before.map(&:to_sym).include?(job_stereotype_key(other_job))
        end

        def job_stereotype_key(job)
          job.class.name.split('::')[0..-2].join('::').demodulize.variableize.to_sym
        end
      end
    end
  end
end
