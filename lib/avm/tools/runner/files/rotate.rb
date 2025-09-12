# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Files
        class Rotate
          runner_with :help do
            desc 'Rotates a file (Like a backup).'
            arg_opt '-L', '--space-limit', 'Limit by <space> the space used by rotated files.'
            pos_arg :path
          end
          def run
            error_message = rotate.run
            fatal_error(error_message) if error_message
          end

          def rotate
            @rotate ||= ::Avm::Data::Rotate.new(
              parsed.path,
              space_limit: parsed.space_limit
            )
          end
        end
      end
    end
  end
end
