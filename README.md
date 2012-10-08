# Trinidad JMX Remote Extension

This extension allows you to enable (remote) JMX monitoring capabilities for
[Trinidad](https://github.com/trinidad/trinidad/).

The extension uses the `JmxRemoteLifecycleListener` which fixes the port used 
by JMX/RMI making things much simpler if you need to connect **jconsole** or 
similar to a remote Trinidad instance running behind a firewall. 

Only the ports are configured via the listener. 
The remainder of the configuration is via the standard system properties for configuring JMX. 

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

Now your server should be setup, do not forget to restart Trinidad ... 
Next you will need to open a SSH session from your local machine.

### Local Setup

SSH tunnel (those ports) into the machine where Trinidad is running :

    $ ssh -N -L9993:localhost:9993 -L9994:localhost:9994 user@remotehost

Download the *catalina-jmx-remote.jar* into your current working directory :

    $ wget http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.30/bin/extras/catalina-jmx-remote.jar

Now open `jconsole`, assuming your JMX connection string looks like this :
**service:jmx:rmi://localhost:9994/jndi/rmi://localhost:9993/jmxrmi**

    $ jconsole -debug -J"-Djava.class.path=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/jconsole.jar:catalina-jmx-remote.jar"  service:jmx:rmi://localhost:9994/jndi/rmi://localhost:9993/jmxrmi

This is assuming a standard JDK installation (non Apple Java) ...

For more details, this guide has been inspired by the excellent blog post :
http://danielkunnath.com/post/9969130766/dancing-with-jmx-jconsole-tomcat-6-ssh

## Copyright

Copyright (c) 2012 [Karol Bucek](https://github.com/kares).
See LICENSE (http://en.wikipedia.org/wiki/MIT_License) for details.
