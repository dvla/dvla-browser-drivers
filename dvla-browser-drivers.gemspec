# frozen_string_literal: true

require_relative 'lib/dvla/browser/drivers/version'

Gem::Specification.new do |spec|
  spec.name = 'dvla-browser-drivers'
  spec.version = DVLA::Browser::Drivers::VERSION
  spec.authors = ['Driver and Vehicle Licensing Agency (DVLA)', 'Tomos Griffiths']
  spec.email = %w[tomos.griffiths@dvla.gov.uk]

  spec.summary =
    <<~MSG
      Browser-drivers has pre-configured web-browser drivers that can be used out-of-the-box for the development of UI based applications.
    MSG

  spec.description =
    <<~MSG
      Browser-drivers has pre-configured web-browser drivers that can be used out-of-the-box for the development of UI based applications.
      It is built using Ruby and utilises the Capybara library (A web application testing platform) to simulate how a user interacts with the applications being tested.
      It also has the facility to run Cuprite, which is a pure Ruby driver utilising Ferrum, a high level API to run headless tests.
    MSG

  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1'
  spec.homepage = 'https://github.com/dvla/dvla-browser-drivers'
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = spec.homepage
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
          'public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").select do |f|
      f.match(/\A(?:lib|bin|exe)/) ||
        f.match(/.(?:gemspec|md|ruby-version)\Z/) ||
        f.match(/\AGemfile\Z/)
    end
  end

  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_dependency 'apparition', '>= 0.6'
  spec.add_dependency 'capybara', '>= 3.37'
  spec.add_dependency 'cuprite', '>= 0.14'
  spec.add_dependency 'dvla-herodotus', '>= 2.0'
  spec.add_dependency 'selenium-webdriver', '>= 4.0'
end
