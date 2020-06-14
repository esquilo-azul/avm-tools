# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gems_subdir = ::File.join(__dir__, 'vendor', 'gems')
Dir["#{gems_subdir}/*"].each do |dir|
  next unless ::File.directory?(dir)

  basename = ::File.basename(dir)
  gem basename, path: "#{gems_subdir}/#{basename}"
end
