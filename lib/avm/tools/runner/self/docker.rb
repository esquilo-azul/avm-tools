# frozen_string_literal: true

require 'avm/docker/runner'

module Avm
  module Tools
    class Runner
      class Self < ::EacRubyUtils::Console::DocoptRunner
        class Docker < ::Avm::Docker::Runner
        end
      end
    end
  end
end
