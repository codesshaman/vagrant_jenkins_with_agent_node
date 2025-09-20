# Vagrant jenkins+agent configuration in debian
Vagrantfile for master and worker nodes cluster

1. Download box for virtualbox [here](https://portal.cloud.hashicorp.com/vagrant/discover/bento/debian-13.0).

2. Clone this repo:

```
gti clone https://github.com/codesshaman/vagrant_jenkins_with_agent_node.git
```

3. Move downloaded box to folder with name "debian":

```
mv /path/to/f44e0d25-758e-11f0-a0a4-42cf001a3211 /path/to/vagrant_jenkins_with_agent_node/debian
```

4. Add box to vagrant configuratiuons:

```
make build
```

5. Initializate vagrant configuration:

```
make
```
