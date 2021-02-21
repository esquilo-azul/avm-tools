# frozen_string_literal: true

require 'eac_ruby_base0/jobs_runner'
require 'eac_ruby_utils/patch'

class Class
  def enable_jobs_runner
    ::EacRubyUtils.patch(self, ::EacRubyBase0::JobsRunner)
  end
end
