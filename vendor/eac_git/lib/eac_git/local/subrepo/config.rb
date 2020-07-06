# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'parseconfig'

module EacGit
  class Local
    class Subrepo
      class Config
        MAPPING = {
          command_version: :cmdver, commit_id: :commit, join_method: :method,
          parent_commit_id: :parent, remote_branch: :branch, remote_uri: :remote
        }.freeze

        class << self
          def from_file(file_path)
            new(
              ::ParseConfig.new(file_path.to_pathname)['subrepo']
            )
          end
        end

        common_constructor :values do
          self.values = values.with_indifferent_access
        end

        MAPPING.each do |method_name, _config_key|
          define_method(method_name) do
            values[MAPPING.fetch(method_name)]
          end

          define_method("#{method_name}=") do |value|
            values[MAPPING.fetch(method_name)] = value
          end
        end

        def to_content
          "[subrepo]\n" + MAPPING.map { |k, v| "  #{v} = #{send(k)}\n" }.join
        end
      end
    end
  end
end
