# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Apps
    module Jobs
      class VariablesSource
        common_constructor :job, :instance

        def read_entry(path, options = {})
          entry_from_job(path) || instance.read_entry(path, options)
        end

        private

        def entry_from_job(path)
          method = path.gsub('.', '_').underscore
          return job.send(method) if job.respond_to?(method, true)
        end
      end
    end
  end
end
