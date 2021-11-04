# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

gems_subdir = ::File.join(__dir__, 'sub')
Dir["#{gems_subdir}/*"].each do |dir|
  next unless ::File.file?(::File.join(dir, 'Gemfile'))

  gem ::File.basename(dir), path: dir
end
