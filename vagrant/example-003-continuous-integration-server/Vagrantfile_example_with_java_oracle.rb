require 'vagrant-openstack-provider'

Vagrant.configure('2') do |config|
  
  #Enable vagrant-env plugin
  config.env.enable
  config.ssh.username = 'ubuntu'  
  config.ssh.private_key_path = "./keypair.pem"

  config.vm.provider :openstack do |os, override|
    os.identity_api_version = ENV['OS_IDENTITY_API_VERSION']
    os.openstack_auth_url = ENV['OS_AUTH_URL']
    os.domain_name        = ENV['OS_DOMAIN_NAME']
    os.username           = ENV['OS_USERNAME']
    os.password           = ENV['OS_PASSWORD']
    os.tenant_name        = ENV['OS_TENANT_NAME']  
    os.project_name       = ENV['OS_PROJECT_NAME']
    os.keypair_name       = ENV['OS_KEY_PAIR_NAME']
    os.region             = ENV['OS_REGION_NAME']
    os.image              = ENV['OS_IMAGE']
  end

  config.vm.define ENV['BOX_NAME'] do |s|
    s.vm.provision "shell", inline: <<-SHELL
    wget --continue --no-check-certificate --header "Cookie: oraclelicense=a" 'http://download.oracle.com/otn-pub/java/jdk/8u151-b12/e758a0de34e24606bca991d704f6dcbf/jdk-8u151-linux-x64.tar.gz'
    tar -xf jdk-8u151-linux-x64.tar.gz
    sudo mkdir -p /usr/lib/jvm
    sudo mv jdk1.8* /usr/lib/jvm/java-8-oracle
    sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8-oracle/jre/bin/java 1091
    sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-8-oracle/bin/javac 1091
    export PATH=$PATH:/usr/lib/jvm/java-8-oracle/bin:/usr/lib/jvm/java-8-oracle/db/bin:/usr/lib/jvm/java-8-oracle/jre/bin
    export JAVA_HOME=/usr/lib/jvm/java-8-oracle
    SHELL
    s.vm.provision "docker" do | docker |
      docker.pull_images "sonarqube:5.6.6-alpine"
      docker.pull_images "gocd/gocd-agent-alpine-3.5:v17.3.0"
      docker.pull_images "gocd/gocd-server:v17.3.0"
      docker.pull_images "jenkinsci/blueocean"
    end
    s.vm.provision "docker_compose" 
    s.vm.provider :openstack do |os, override|
      os.server_name = ENV['OS_SERVER_NAME']
      os.flavor = ENV['OS_FLAVOR']
      override.vm.synced_folder '.', '/vagrant', disabled: true
    end
  end
end
