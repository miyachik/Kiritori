set :branch,ENV["BRANCH"] || "develop"
set :stage, :development
set :rails_env, 'development'
#set :pty, false

set :ssh_options, keys: [File.expand_path('~/.ssh/inkochan.pem')],
                  forward_agent: false,
                  port: 22,
                  auth_methods: %w(publickey)
server '13.112.205.87', user: 'ec2-user',
                    roles: %w(web app db)
