# frozen_string_literal: true

require 'eac_git/executables'
require 'eac_ruby_utils/core_ext'

module EacGit
  # A Git repository in local filesystem.
  class Local
    require_sub __FILE__, include_modules: true

    common_constructor :root_path do
      self.root_path = root_path.to_pathname
    end

    def descendant?(descendant, ancestor)
      base = merge_base(descendant, ancestor)
      return false if base.blank?

      revparse = command('rev-parse', '--verify', ancestor).execute!.strip
      base == revparse
    end

    def merge_base(*commits)
      refs = commits.dup
      while refs.count > 1
        refs[1] = merge_base_pair(refs[0], refs[1])
        return nil if refs[1].blank?

        refs.shift
      end
      refs.first
    end

    def command(*args)
      ::EacGit::Executables.git.command('-C', root_path.to_path, *args)
    end

    def rev_parse(ref, required = false)
      r = command('rev-parse', ref).execute!(exit_outputs: { 128 => nil, 32_768 => nil })
      r.strip! if r.is_a?(String)
      return r if r.present?
      return nil unless required

      raise "Reference \"#{ref}\" not found"
    end

    def subrepo(subpath)
      ::EacGit::Local::Subrepo.new(self, subpath)
    end

    def to_s
      "#{self.class}[#{root_path}]"
    end

    private

    def merge_base_pair(commit1, commit2)
      command('merge-base', commit1, commit2).execute!(exit_outputs: { 256 => nil }).strip
    end
  end
end
