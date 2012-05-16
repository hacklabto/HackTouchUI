require File.join File.dirname(__FILE__), "./lib-bootstrap"
include TakeANap

unless homebrew?
  puts "not brew. Non-OSX Not yet tested, ask Rob :("
  exit
end


# System Requirements
# --------------------------------
system_dependancies do

  ["bundler", "padrino"].each {|g| gem g}

  unix_package "redis", :check => "redis-server -v" do
    system("brew install redis") if homebrew?
    #system("bash <<(curl http://github.com/wayneeseguin/redis-installer/raw/master/bin/install-redis)")
  end

end


# App Requirements
# --------------------------------

# Install this project's bundle
system("bundle install")

# Set up the database
#["reset_db", "ar:create", "ar:migrate", "add_admin", "bootstrap_end"].each do |t|
#  system("padrino rake #{t} --trace")
#end
