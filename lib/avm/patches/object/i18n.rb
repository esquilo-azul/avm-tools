# frozen_string_literal: true

require 'avm/patches/class/i18n'

class Object
  def translate(entry_suffix, values = {})
    self.class.translate(entry_suffix, values)
  end
end
