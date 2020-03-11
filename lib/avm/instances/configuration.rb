# frozen_string_literal: true

require 'eac_ruby_utils/configs'
require 'yaml'

module Avm
  module Instances
    class Configuration < ::EacRubyUtils::Configs
      FILENAMES = %w[.avm.yml .avm.yaml].freeze

      class << self
        def find_by_path(path)
          path = ::Pathname.new(path.to_s).expand_path unless path.is_a?(::Pathname)
          if path.directory?
            FILENAMES.each do |filename|
              file = path.join(filename)
              return new(file) if file.exist?
            end
          end
          find_by_path(path.dirname) unless path.root?
        end
      end

      def initialize(path)
        super(nil, storage_path: path)
      end
    end
  end
end
