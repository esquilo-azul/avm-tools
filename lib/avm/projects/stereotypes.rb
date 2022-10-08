# frozen_string_literal: true

require 'avm/git/launcher_stereotypes/git'
require 'avm/git/launcher_stereotypes/git_subrepo'
require 'avm/git/launcher_stereotypes/git_subtree'
require 'avm/eac_ruby_base1/launcher_stereotypes/base'
require 'eac_ruby_utils/core_ext'

module Avm
  module Projects
    module Stereotypes
      require_sub __FILE__, base: nil
    end
  end
end
