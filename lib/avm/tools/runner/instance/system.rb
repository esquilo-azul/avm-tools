# frozen_string_literal: true

module Avm
  module Tools
    class Runner
      class Instance < ::Avm::Instances::Runner
        class System
          ENVVAR_PARSER = /\A([^=]+)=(.+)\z/.to_parser do |m|
            ::Struct.new(:name, :value).new(m[1].strip, m[2].strip)
          end

          runner_with :help do
            desc 'Execute a command in the instance\'s environment.'
            arg_opt '-C', '--chdir'
            arg_opt '-e', '--envvar', repeat: true
            pos_arg :command_args, required: true, repeat: true
          end

          delegate :command_args, to: :parsed

          def run
            start_banner
            run_command
          end

          # @return [Pathname]
          def chdir
            (parsed.chdir || instance.install_path).to_pathname
          end

          private

          # @return [EacRubyUtils::Envs::Command]
          def command_without_envvars
            instance.host_env.command(*command_args).chdir(chdir)
          end

          # @return [EacRubyUtils::Envs::Command]
          def command
            envvars.inject(command_without_envvars) { |a, e| a.envvar(e.name, e.value) }
          end

          # @return [Hash<String, String>]
          def envvars
            parsed.envvar.map { |v| ENVVAR_PARSER.parse!(v) }
          end

          def run_command
            command.system!
          end

          def start_banner
            infov 'Instance', instance
            infov 'Environment', instance.host_env
            infov 'Directory', chdir
            infov 'Envvars', envvars.map { |e| "#{e.name}=#{e.value}" }.join(', ')
            infov 'Command', ::Shellwords.join(command_args)
          end
        end
      end
    end
  end
end
