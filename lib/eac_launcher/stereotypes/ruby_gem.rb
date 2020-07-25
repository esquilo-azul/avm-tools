# frozen_string_literal: true

require 'avm/projects/stereotype'
require 'eac_launcher/ruby/gem/specification'
require 'eac_launcher/stereotypes/ruby_gem/publish'

module EacLauncher
  module Stereotypes
    class RubyGem
      include Avm::Projects::Stereotype

      class << self
        def match?(path)
          Dir.glob(File.join(path.real, '*.gemspec')).any?
        end

        def color
          :red
        end

        def load_gemspec(gemspec_file)
          ::EacLauncher::Ruby::Gem::Specification.new(gemspec_file)
        end
      end
    end
  end
end
