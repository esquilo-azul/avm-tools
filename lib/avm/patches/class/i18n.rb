# frozen_string_literal: true

require 'avm/patches/i18n'

class Class
  def translate(entry_suffix, values = {})
    ::I18n.translate(translate_entry_full(entry_suffix), values)
  end

  def translate_entry_full(entry_suffix)
    "#{translate_entry_self_prefix}.#{entry_suffix}"
  end

  def translate_entry_self_prefix
    name.underscore.gsub('/', '.')
  end
end
