# frozen_string_literal: true

require 'eac_ruby_utils/configs'
require 'yaml'

module Avm
  module Instances
    class Configuration < ::EacRubyUtils::Configs
      FILENAMES = %w[.avm.yml .avm.yaml].freeze

      class << self
        def find_by_path(path)
          path = ::Pathname.new(path.to_s) unless path.is_a?(::Pathname)
          internal_find_path(path.expand_path)
        end

        private

        def internal_find_path(absolute_pathname)
          if absolute_pathname.directory?
            FILENAMES.each do |filename|
              file = absolute_pathname.join(filename)
              return new(file) if file.exist?
            end
          end
          internal_find_path(absolute_pathname.dirname) unless absolute_pathname.root?
        end
      end

      def initialize(path)
        super(nil, storage_path: path)
      end
    end
  end
end
