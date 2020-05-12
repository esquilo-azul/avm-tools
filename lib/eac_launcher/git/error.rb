# frozen_string_literal: true

module EacLauncher
  module Git
    class Error < StandardError
      def initialize(git_instance, message)
        super("#{message} (Repository: #{git_instance})")
      end
    end
  end
end
