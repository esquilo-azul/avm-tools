# frozen_string_literal: true

module EacRubyGemsUtils
  module Tests
    class Multiple
      class Result
        common_constructor :result

        COLORS = {
          ::EacRubyGemsUtils::Tests::Base::RESULT_FAILED => :red,
          ::EacRubyGemsUtils::Tests::Base::RESULT_NONEXISTENT => :white,
          ::EacRubyGemsUtils::Tests::Base::RESULT_SUCCESSFUL => :green
        }.freeze

        def tag
          result.to_s.send(color)
        end

        def color
          COLORS.fetch(result)
        end
      end
    end
  end
end
