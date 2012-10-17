# Trinidad JMX Remote Extension

This extension allows you to enable remote JMX (Java Management Extensions) 
monitoring capabilities for [Trinidad](https://github.com/trinidad/trinidad/).

The extension sets up a Tomcat lifecycle listener which fixes the ports used by
JMX/RMI to static ones (known ahead of time) thus making things much simpler if
you need to connect [JConsole](http://bit.ly/jconsole) or any similar tool to a
remote Trinidad instance running behind a firewall.

Please note that only the ports are configured via the listener, the remainder 
of the configuration is via the standard system properties for configuring JMX. 

## Install

Along with Trinidad in your application's *Gemfile*:

```ruby
  group :server do
    platform :jruby do
      gem 'trinidad', :require => false
      gem 'trinidad_jmx_remote_extension', :require => false
    end
  end
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install trinidad_jmx_remote_extension

## Setup

Like all extensions it is setup in the configuration file e.g. *trinidad.yml* :

```yaml
---
  # ...
  extensions:
    jmx_remote:
      useLocalPorts: true # bind to localhost than setup a ssh tunnel
      # assuming you'll setup the tunnel you shall remember these ports :
      rmiRegistryPortPlatform: 9993
      rmiServerPortPlatform: 9994
```

Now your server should be setup, do not forget to restart Trinidad ... You might
want to disable JMX authentication (at first) and set the RMI hostname e.g. by :

    $ jruby -J-Dcom.sun.management.jmxremote.ssl=false -J-D-Dcom.sun.management.jmxremote.authenticate=false -J-Djava.rmi.server.hostname=<trinidad-host-name> -S trinidad -e production

Next you will need to make sure you can SSH into the remote machine locally.

### Local Setup

SSH tunnel (those ports) into the machine where Trinidad is running :

    $ ssh -N -L9993:localhost:9993 -L9994:localhost:9994 user@remotehost

Download the *catalina-jmx-remote.jar* into your current working directory :

    $ wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.32/bin/extras/catalina-jmx-remote.jar

You shall use the same *catalina-jmx-remote.jar* locally as the extension is 
using on the remote Trinidad machine, this guide reflects the .jar distributed 
with the latest version of the gem. When in doubt simply `gem install` the same
version locally and copy the .jar from the unpacked gem e.g. using :

    $ jruby -rubygems -e "require 'trinidad_jmx_remote_extension'; puts Trinidad::Extensions::JmxRemote::JAR_PATH"

Now open `jconsole`, assuming your JMX connection string looks like this :
**service:jmx:rmi://localhost:9994/jndi/rmi://localhost:9993/jmxrmi**

    $ jconsole -debug -J"-Djava.class.path=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/jconsole.jar:catalina-jmx-remote.jar" service:jmx:rmi://localhost:9994/jndi/rmi://localhost:9993/jmxrmi

This is assuming a standard JDK installation (non Apple Java) ...

For more details, this guide has been inspired by the following excellent post :
http://danielkunnath.com/post/9969130766/dancing-with-jmx-jconsole-tomcat-6-ssh

## Copyright

Copyright (c) 2012 [Karol Bucek](https://github.com/kares).
See LICENSE (http://en.wikipedia.org/wiki/MIT_License) for details.
