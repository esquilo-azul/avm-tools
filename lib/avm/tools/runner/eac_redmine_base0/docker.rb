# frozen_string_literal: true

require 'avm/docker/runner'

module Avm
  module Tools
    class Runner < ::EacRubyUtils::Console::DocoptRunner
      class EacRedmineBase0 < ::EacRubyUtils::Console::DocoptRunner
        class Docker < ::Avm::Docker::Runner
        end
      end
    end
  end
end
