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

bundle
gem install foreman
bundle exec rake db:migrate
cap db:pull

## Start
foreman start
