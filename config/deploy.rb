require "bundler/capistrano"

set :application, "audrey2"
set :user, "gt"
set :deploy_to, "/home/gt/audrey2"

default_run_options[:pty] = true

#############################################################
# Git
#############################################################

set :scm, :git

#keep a local cache to speed up deploys
set :deploy_via, :remote_cache
# Use developer's local ssh keys when git clone/updating on the remote server
ssh_options[:forward_agent] = true

require 'capistrano-unicorn'


role :web, "108.171.174.224"
role :app, "108.171.174.224"

set :repository,  "git@github.com:ShelbyTV/audrey2.git"
set :branch, "master"
set :rails_env, "production"
set :unicorn_env, "production"
set :app_env,     "production"

# this didn't seem to be necessary with multistage deployment - oh well
after 'deploy:restart', 'unicorn:restart'