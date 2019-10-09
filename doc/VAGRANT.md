# How to create and setup a development virtual machine for old ruby/rails

_Using VirtualBox and Vagrant_

## Install and create a virtual machine

Install virtualbox and Vagrant:

```bash
brew cask install virtualbox
brew cask install vagrant

vagrant box add hashicorp/precise64
cd BookcampingApp
vagrant init hashicorp/precise64
```

## Configure the virtual machine

All the configuration is done by editing the `Vagrant` file.

First add a shared folder to see the current folder from the virtual machine:

`config.vm.synced_folder ".", "/home/vagrant/my-project"`

Then add forwarded ports to connect to the web server of the VM from outside:

`config.vm.network "forwarded_port", guest: 3000, host: 3333`

## Start the VM and login

Start and connect to the virtual machine:

```
$ vagrant up
$ vagrant ssh
```

If you want make changes to Vagrant file you need to reload:

```
$ vagrant reload
```

## Ubuntu setup

_All the following steps are required to be executed inside the vm unless notice_

Install the required software:

```bash
sudo apt-get update
sudo apt-get install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev
```

Install rbenv:

```
git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
```

Install ruby-build:

```
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

Install ruby, gems, app:

```bash
rbenv install 2.0.0-p648
rbenv global 2.0.0-p648

# Locale for postgres
sudo localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
sudo apt-get install postgresql-9.1

gem install bundler -v 1.7.6
sudo apt-get install libpq-dev
gem install pg -v '0.18.1'
bundle
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo -u postgres psql

(postgres)
create role vagrant with createdb login password 'vagrant';
cat 'localhost:5432:Bookcamping:vagrant:vagrant' > ~/.pgpass

update pg_database set datistemplate=false where datname='template1';
drop database Template1;
create database template1 with owner=postgres encoding='UTF-8'
  lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;
update pg_database set datistemplate=true where datname='template1';
exit
(/postgres)

rake db:create
cat data/dump.sql | PGPASSWORD=dani psql -U dani Bookcamping


sudo apt-get install memcached
sudo apt-get install redis-server
rails s
```
