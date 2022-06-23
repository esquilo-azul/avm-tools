# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module Avm
  module Sources
    class Base
      module Subs
        # @return [Enumerable<Avm::Sources::Base>]
        def subs
          scm.subs.map { |subrepo| ::Avm::Registry.sources.detect(subrepo.path, parent: self) }
        end
      end
    end
  end
end
