# frozen_string_literal: true

require 'eac_ruby_utils/rspec/conditional'
require 'eac_ruby_utils/envs'

::EacRubyUtils.require_sub(__FILE__)
require 'eac_git/rspec'
::EacGit::Rspec.configure
require 'eac_docker/rspec'
::EacDocker::Rspec.configure
