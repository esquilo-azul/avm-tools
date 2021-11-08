# frozen_string_literal: true

require 'avm/source_stereotypes/base'
require 'avm/eac_ruby_base1/source_stereotypes/update'
require 'eac_ruby_utils/core_ext'

module Avm
  module EacRubyBase1
    module SourceStereotypes
      class Base < ::Avm::SourceStereotypes::Base
        def gemfile_path
          source.path.join('Gemfile')
        end

        def valid?
          gemfile_path.exist? || gemspec_file.exist?
        end

        def update_source(source)
          ::Avm::EacRubyBase1::SourceStereotypes::Update.new(source)
        end
      end
    end
  end
end