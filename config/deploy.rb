require "bundler/capistrano"
load 'deploy/assets'

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/postgresql_backup"
load "config/recipes/rbenv"
load "config/recipes/check"
load "config/recipes/config_files"
load "config/recipes/assets"
load "config/recipes/newrelic"
load "config/recipes/log"
load "config/recipes/apt"
load "config/recipes/sitemap"

server "176.58.98.122", :web, :app, :db, primary: true

set :application, "BookcampingApp"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:Bookcamping/BookcampingApp.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# nginx stuff
set :server_names, 'bookcamping.cc videocamping.cc bookcamping.org *.bookcamping.cc *.videcamping.cc *.bookcamping.org'
set :nginx_page_caching, true

# newrelic settings
set :newrelic_license_key, '0a0d3776322392d64886579d8e72499290edd79a'

# config files settings
set :config_files, []


after "deploy", "deploy:cleanup" # keep only the last 5 releases

