# Swarmlab

Get started with Docker 1.12 Swarm Mode fast.

Clone this repo and run

```
$ cd swarmlab
$ vagrant up --provider virtualbox
```

This will create three Ubuntu Wily VMs with Docker 1.12 preinstalled.

This allows to experiment with new Docker Swarm Mode features easily.

# Known Issues
  - With `ubuntu/wily` (as it is configured) it works fine, but upgrading to `ubuntu/xenial` throws an error (https://github.com/mitchellh/vagrant/issues/7288)
  - A version of Vagrant < 1.8.5 may cause problems.
