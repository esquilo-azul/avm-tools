# frozen_string_literal: true

require 'avm/launcher/errors/base'

module Avm
  module Launcher
    module Errors
      class NonProject < ::Avm::Launcher::Errors::Base
        def initialize(path)
          super("#{path} is not a project")
        end
      end
    end
  end
end
