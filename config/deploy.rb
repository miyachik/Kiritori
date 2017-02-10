# frozen_string_literal: true
set :application, 'Kiritori'
set :repo_url, 'https://github.com/miyachik/Kiritori.git'
set :deploy_to, '/usr/local/app'
set :keep_releases, 3
set :rbenv_path, '/home/ec2-user/.rbenv'
set :rbenv_type, :system # :system or :user
set :rbenv_ruby, '2.2.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_roles, :all # default value
set :linked_dirs, %w(bin log tmp/backup tmp/pids tmp/cache tmp/sockets vendor/bundle tmp/unicorn)
set :bundle_jobs, 4
set :unicorn_pid, -> { File.join(shared_path, 'tmp', 'pids', 'unicorn.pid') }
set :unicorn_config_path, -> { File.join(current_path, 'config', 'unicorn', "#{fetch(:rails_env)}.rb") }
namespace :deploy do
  after :publishing, :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
    end
  end
end
