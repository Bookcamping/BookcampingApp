require "bundler/capistrano"
require 'sidekiq/capistrano'
load 'deploy/assets'

load 'config/recipes/all'

server "176.58.98.122", :web, :app, :db, primary: true
server "198.199.71.40", :web, :app, :db, primary: true

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
set :config_files, ['database.yml', 'newrelic.yml']

set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :custom do
  task :archive_symlink, roles: :app do
    run "ln -s #{shared_path}/system #{release_path}/public/archivos"
  end
  after "deploy:finalize_update", "custom:archive_symlink"
end
