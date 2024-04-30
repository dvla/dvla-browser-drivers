# frozen_string_literal: true

require_relative 'lib/dvla/browser/drivers/version'

Gem::Specification.new do |spec|
  spec.name = 'dvla-browser-drivers'
  spec.version = DVLA::Browser::Drivers::VERSION
  spec.authors = ['Driver and Vehicle Licensing Agency (DVLA)','Tomos Griffiths']
  spec.email = %w[tomos.griffiths@dvla.gov.uk]

  spec.summary = 'Browser-drivers has pre-configured web-browser drivers that ' \
                 'can be used out-of-the-box for the development of UI based applications.'
  spec.description = 'Browser-drivers has pre-configured web-browser drivers that '                                   \
                     'can be used out-of-the-box for the development of UI based applications. '                      \
                     'It is built using Ruby and utilises the Capybara library (A web application testing platform) ' \
                     'to simulate how a user interacts with the applications being tested. '                          \
                     'It also has the facility to run Cuprite, which is a pure Ruby driver utilising Ferrum, '        \
                     'a high level API to run headless tests.'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1'
  spec.homepage = 'https://github.com/dvla/dvla-browser-drivers'
  if spec.respond_to?(:metadata)
    # spec.metadata['allowed_push_host'] = 'TODO: Set to 'http://mygemserver.com''

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

  # Uncomment to register a new dependency of your gem
  spec.add_runtime_dependency 'apparition', '>= 0.6'
  spec.add_runtime_dependency 'capybara', '>= 3.37'
  spec.add_runtime_dependency 'cuprite', '>= 0.14'
  spec.add_runtime_dependency 'dvla-herodotus', '>= 2.0'
  spec.add_runtime_dependency 'selenium-webdriver', '>= 4.0'

  spec.add_development_dependency 'bundler-audit', '~> 0.9'
  spec.add_development_dependency 'dvla-lint', '~> 1.7'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.11'
  spec.add_development_dependency 'rspec-sonarqube-formatter', '~> 1.5'
  spec.add_development_dependency 'simplecov', '~> 0.22'
  spec.add_development_dependency 'simplecov-console', '~> 0.9'

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
