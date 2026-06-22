# frozen_string_literal: true

require_relative 'lib/my_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'my_test_kit'
  spec.version       = MyTestKit::VERSION
  spec.authors       = ['Author Name']
  spec.email         = ['author@example.com']
  spec.summary       = 'Inferno test kit'
  spec.description   = 'Inferno test kit'
  spec.homepage      = 'https://github.com/example/my-test-kit'
  spec.license       = 'Apache-2.0'
  spec.add_dependency 'inferno_core', '>= 1.0.6'
  spec.add_dependency 'smart_app_launch_test_kit', '>= 0.4.0'
  spec.add_dependency 'tls_test_kit', '~> 0.2.0'
  spec.add_development_dependency 'database_cleaner-sequel', '~> 1.8'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'webmock', '~> 3.11'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.6')
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/example/my-test-kit'
  spec.metadata['rubygems_mfa_required'] = 'true'
  spec.files = [
    Dir['lib/**/*.rb'],
    Dir['lib/**/*.json'],
    Dir['lib/**/*.tgz'],
    Dir['lib/**/*.yml'],
    'LICENSE'
  ].flatten

  spec.require_paths = ['lib']
end
