# frozen_string_literal: true

module Avm
  module Stereotypes
    module Postgresql
      Dir["#{File.dirname(__FILE__)}/#{::File.basename(__FILE__, '.*')}/*.rb"].each do |path|
        require path
      end
    end
  end
end
