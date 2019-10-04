# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'
require 'avm/templates'

class Object
  class << self
    def template
      @template ||= ::Avm::Templates.template(name.underscore)
    end
  end

  def template
    self.class.template
  end
end
