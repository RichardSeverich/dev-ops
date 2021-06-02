# Vagrant virtual machine
This virtual machine is for continuous integration. For the elaboration of this virtual machine we use the vagrant file to define the scripts that are executed in the virtual machine.

#**Pre requeriments for the use:**

**Environmental requirements**
 + Open Stack Server
 + Install vagrant.
 + Install vagrant-openstack-provider plugin
 + Install vagrant-docker-compose plugin
 + Install vagrant-env plugin

**Steps**
 + 1. Install Vagrant
 + 2. Install Vagrant-openstack-provider plugin
 	```
 	$ vagrant plugin install vagrant-openstack-provider
 	```
 + 3. Install vagrant-docker-compose plugin
	```
	$ vagrant plugin install vagrant-docker-compose
	```
 + 4. Install vagrant-env plugin
 	```
 	$ vagrant plugin install vagrant-env
 	```
