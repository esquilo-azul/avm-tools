# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacDocker
  class Container
    enable_immutable
    immutable_accessor :interactive, :temporary, :tty, type: :boolean
    immutable_accessor :env, type: :hash
    immutable_accessor :capability, :command_arg, :volume, type: :array
    attr_reader :id
    common_constructor :image

    def immutable_constructor_args
      [image]
    end

    alias immutable_volume volume

    def hostname
      ::EacDocker::Executables.docker.command(
        'inspect', '--format={{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}',
        id
      ).execute!.strip
    end

    def on_detached
      command = ::EacDocker::Executables.docker.command(*(%w[run --detach] + run_command_args))
      self.id = command.execute!.strip
      begin
        yield(self)
      ensure
        stop
      end
    end

    def volume(left_part, right_part = null)
      immutable_volume(right_part.if_present(left_part) { |v| "#{left_part}:#{v}" })
    end

    def run_command
      ::EacDocker::Executables.docker.command('run', *run_command_args)
    end

    def run_command_args
      run_command_boolean_args + run_command_capabilities_args + run_command_envs_args +
        run_command_volumes_args + [image.provide.id] + command_args
    end

    def stop
      ::EacDocker::Executables.docker.command('stop', id).execute!
    end

    private

    attr_writer :id

    def run_command_boolean_args
      r = []
      r << '--interactive' if interactive?
      r << '--tty' if tty?
      r << '--rm' if temporary?
      r
    end

    def run_command_capabilities_args
      capabilities.flat_map { |capability| ['--cap-add', capability] }
    end

    def run_command_volumes_args
      volumes.flat_map { |volume| ['--volume', volume] }
    end

    def run_command_envs_args
      envs.flat_map { |name, value| ['--env', "#{name}=#{value}"] }
    end
  end
end
