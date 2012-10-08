require 'trinidad'
require "trinidad_jmx_remote_extension/version"

module Trinidad
  module Extensions
    module JmxRemote
      unless const_defined?(:JAR_PATH)
        JAR_PATH = File.expand_path('catalina-jmx-remote.jar', File.dirname(__FILE__))
      end
    end
    class JmxRemoteServerExtension < ServerExtension

      def configure(tomcat)
        load JmxRemote::JAR_PATH
        listener = Java::OrgApacheCatalinaMbeans::JmxRemoteLifecycleListener.new
        options.each do |key, value| # e.g. useLocalPorts: true
          if listener.respond_to? method = "set#{key.to_s.upcase}"
            listener.send(method, value)
          elsif listener.respond_to? method = "#{key}="
            listener.send(method, value)
          end
        end
        tomcat.server.add_lifecycle_listener listener
      end
      
    end
  end
end
