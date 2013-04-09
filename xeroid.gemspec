# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xeroid/version'

Gem::Specification.new do |gem|
  gem.name          = "xeroid"
  gem.version       = Xeroid::VERSION
  gem.authors       = ["Matt Patterson"]
  gem.email         = ["matt@reprocessed.org"]
  gem.description   = <<-EOD
Xero API client with a couple of differences:

== Proper value objects
Calls to the API return immutable value objects which are safe and cannot, for example, make more API calls behind the scenes

== Separation of Serialisation / Deserialisation and data.
The serialisation code is not part of the value object code. This means that you aren't required to satisfy the full validation requirements of a Contact if you want to use them in a context (e.g. new invoice creation) where Xero allow a more minimal data set than would be allowed for direct Contact API endpoint calls.
EOD
  gem.summary       = %q{Xero API client}
  gem.homepage      = "https://github.com/fidothe/xeroid"

  gem.files         = Dir.glob([
    'lib/**/*.rb',
    'spec/**/*.rb',
    'README.md',
    'LICENSE.txt',
    'Rakefile'
  ])
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'oauth', '~> 0.4.7'
  gem.add_dependency 'builder', '~> 3.2.0'
  gem.add_dependency 'nokogiri', '~> 1.5.0'

  gem.add_development_dependency 'rspec', '~> 2.0'
  gem.add_development_dependency 'cucumber', '~> 1.2.5'
  gem.add_development_dependency 'webmock', '~> 1.11.0'
  gem.add_development_dependency 'vcr', '~> 2.4'
  gem.add_development_dependency 'factory_girl', '~> 4.2'
end
