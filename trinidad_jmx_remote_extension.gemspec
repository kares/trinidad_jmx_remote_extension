# -*- encoding: utf-8 -*-
require File.expand_path('../lib/trinidad_jmx_remote_extension/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "trinidad_jmx_remote_extension"
  gem.version       = Trinidad::Extensions::JmxRemote::VERSION
  
  gem.description   = %q{JMX Remote Extension for Trinidad}
  gem.summary       = %q{TODO: Write a gem summary}
  
  gem.authors       = ["Karol Bucek"]
  gem.email         = ["self@kares.org"]
  gem.homepage      = 'http://github.com/kares/trinidad_jmx_remote_extension'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test}/*`.split("\n")
  
  gem.rdoc_options = ["--charset=UTF-8"]
  gem.extra_rdoc_files = %w[ README.md LICENSE ]
  
  gem.require_paths = ["lib"]
  gem.add_dependency('trinidad', '>= 1.3.5')
  gem.add_development_dependency('rake')
end