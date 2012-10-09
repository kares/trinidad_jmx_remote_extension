require File.expand_path('test_helper', File.dirname(__FILE__))
require 'yaml'

module Trinidad
  module Extensions
    class JmxRemoteServerExtensionTest < Test::Unit::TestCase
      
      test "loads jar and configures listener" do
        config = File.expand_path('trinidad.yml', File.dirname(__FILE__))
        options = YAML.load( File.read(config) )
        config = Trinidad.configure!(options)
        Trinidad::Extensions.configure_server_extensions(config[:extensions], tomcat)
        
        begin
          Java::OrgApacheCatalinaMbeans::JmxRemoteLifecycleListener
        rescue NameError => e
          flunk "failed loading classes from catalina-jmx-remote.jar #{e.inspect}"
        end
        
        listeners = tomcat.server.find_lifecycle_listeners
        assert listeners.size > 0
        assert_kind_of org.apache.catalina.mbeans.JmxRemoteLifecycleListener, listeners[0]
        assert_true listeners[0].use_local_ports?
        
        assert_equal 9993, listeners[0].rmi_registry_port_platform
        assert_equal 9994, listeners[0].rmi_server_port_platform
      end
      
      private

      def tomcat
        @tomcat ||= org.apache.catalina.startup.Tomcat.new
      end
      
    end
  end
end