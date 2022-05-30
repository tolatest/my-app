namespace :configdb do
     desc "Get db users cred and upload to db yaml file"
     task :setupdb do
       ask(:db_user, 'db_user')
       ask(:db_pass, 'db_pass')
       ask(:db_name, 'db_name')
       # ask(:db_host, 'db_host')
       setup_config = <<-EOF
   #{fetch(:rails_env)}:
     adapter: postgresql
     database: #{fetch(:db_name)}
     username: #{fetch(:db_user)}
     password: #{fetch(:db_pass)}
     socket: /var/run/postgresql/.s.PGSQL.5432
   #  host: #{fetch(:db_host)}
   EOF
       on roles(:app) do
         execute "mkdir -p #{shared_path}/config"
         upload! StringIO.new(setup_config), "#{shared_path}/config/database.yml"
       end
     end
   end
