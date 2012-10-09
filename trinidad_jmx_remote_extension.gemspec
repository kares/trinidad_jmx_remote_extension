# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "trinidad_jmx_remote_extension/version"

Gem::Specification.new do |gem|
  gem.name          = "trinidad_jmx_remote_extension"
  gem.version       = Trinidad::Extensions::JmxRemote::VERSION
  
  gem.description   = %q{JMX Remote Extension for Trinidad}
  gem.summary       = %q{The extension sets up a Tomcat lifecycle listener
  which fixes the port used by JMX/RMI to static ones known ahead of time thus 
  making things much simpler if you need to connect JConsole or similar to a 
  remote Trinidad instance running behind a firewall (e.g. via SSH).}
  
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
  gem.add_development_dependency('test-unit', '>= 2.4')
end