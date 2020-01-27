# frozen_string_literal: true

module Avm
  module Instances
    module EntryKeys
      {
        database: %w[id hostname name password port system username],
        web: %w[authority hostname path port scheme url userinfo]
      }.each do |prefix, suffixes|
        suffixes.each do |suffix|
          key = "#{prefix}.#{suffix}"
          const_set(key.gsub('.', '_').upcase, key)
        end
      end
    end
  end
end
