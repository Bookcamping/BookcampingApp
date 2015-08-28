# Bookcamping appplication

bookcamping.cc

- Travis CI
[![Build Status](https://secure.travis-ci.org/Bookcamping/BookcampingApp.png)](http://travis-ci.org/Bookcamping/BookcampingApp)

- Code Climate
https://codeclimate.com/github/Bookcamping/BookcampingApp


## Install

Pull this repo. Add config/database.yml

mkdir tmp

DALLI requires memcached:
[MacOSX] brew install memcached

Sidekiq requires redis:
[MacOSX] brew install redis

```bash
git submodule update --init --recursive
bundle
gem install foreman
gem install capistrano
bundle exec rake db:create
bundle exec cap db:pull
```

## Start
foreman start
