HackTouch UI
=============


Installation Instructions
--------------------------

1. Install rbenv (or RVM) and ruby 1.9.3
2. `bundle install`

Running the Production Server
-----------------------------

1. `unicorn -p 8081`

Development
-----------

You can use [vagrant](http://www.vagrantup.com/) to fire up a development VM with all the neccessary dependencies within. You will get a ready to launch environment (rvm, ruby, bundled gems will be deployed via puppet).

Just run `vagrant up`. Once the VM is running, you can ssh into it via `vagrant ssh`. The app and code can be found in `/vagrant`, which is shared between your host and the VM. 

To finish the development setup, in `/vagrant` run `padrino rake ar:setup` to create, migrate, and seed the database. Then run `padrino s` to start a padrino development server on port 3000, which vagrant forwards to your host's port 3000. You can access the new Hacktouch site at `http://localhost:3000`.

`padrino --help` inside the `/vagrant` directory will tell you good things. `padrino c` is handy. 
