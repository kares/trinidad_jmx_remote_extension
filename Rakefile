#!/usr/bin/env rake
require "bundler/gem_tasks"

jar_path = 'lib/catalina-jmx-remote.jar'

desc "update (bundled) catalina-jmx-remote.jar"
task :update_jar, :version do |_, args| # e.g. `rake update_jar[7.0.30]`
  require 'open-uri'; require 'fileutils'
  uri_start = 'http://archive.apache.org/dist/tomcat/tomcat-7/'
  uri_end = '/bin/extras/catalina-jmx-remote.jar'
  jar_file = open(uri = "#{uri_start}v#{args[:version]}#{uri_end}",'rb')
  Rake::Task['remove_jar'].invoke
  File.open(jar_path, 'wb') { |file| file.write jar_file.read }
  # and update README section to match the same .jar :
  readme = File.expand_path('README.md', File.dirname(__FILE__))
  old_uri = /#{Regexp.escape(uri_start)}v.*?#{Regexp.escape(uri_end)}/
  lines = IO.readlines(readme).map { |line| line.gsub(old_uri, uri) }
  File.open(readme, 'w') { |file| file.write(lines.join) }
end

task :remove_jar do
  File.delete jar_path if File.exist? jar_path
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*test.rb']
  t.verbose = true
end

task :default => :test