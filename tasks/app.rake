task :start do
  exec "bundle exec thin start -e #{Padrino.env} --ssl"
end

task :reset_db do
  require 'fileutils'
  FileUtils.rm "./db/app_development.db"
end

task :add_admin do
  require 'highline/import'

  account = Account.new
  account.role = "admin"

  account.email = ask("Enter your email:  ")
  account.password = ask("Enter your password:  ") { |q| q.echo = false }
  account.password_confirmation = ask("Confirm your password:  ") { |q| q.echo = false }

  account.save!
end

task :bootstrap_end do
  require "colorize"
  puts "#{"Installation Completed Successfully".green} #{"(?)".red}"
end