# vagrant_master_slaves_configuration_debian
Vagrantfile for master and worker nodes cluster

1. Download box for virtualbox [here](https://portal.cloud.hashicorp.com/vagrant/discover/bento/debian-12.9).

2. Clone this repo:

```
gti clone https://github.com/codesshaman/vagrant_one_master-slave_debian.git
```

3. Move downloaded box to folder with name "debian":

```
mv 593343a7-f094-11ef-9b45-067fe3f641fb vagrant_one_master-slave_debian/debian
```

4. Add box to vagrant configuratiuons:

```
make build
```

5. Initializate vagrant configuration:

```
make
```
