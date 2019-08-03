# frozen_string_literal: true

require 'avm/instances/base'
require 'avm/stereotypes/postgresql/instance_with'

module Avm
  module Stereotypes
    module EacWordpressBase0
      class Instance < ::Avm::Instances::Base
        include ::Avm::Stereotypes::Postgresql::InstanceWith
      end
    end
  end
end
