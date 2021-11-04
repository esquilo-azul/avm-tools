# frozen_string_literal: true

require 'avm/eac_ubuntu_base0/docker_image'
require 'eac_docker/images/base'
require 'eac_docker/registry'

::RSpec.describe ::Avm::EacUbuntuBase0::DockerImage do
  let(:registry) { ::EacDocker::Registry.new('stub') }
  let(:instance) { described_class.new(registry) }

  describe '#provide' do
    it do
      expect(instance.provide).to be_a(::EacDocker::Images::Base)
    end
  end
end
