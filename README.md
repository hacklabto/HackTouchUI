HackTouch UI
=============


Installation Instructions
--------------------------

NOTE: This is not working at the moment due to some issues with permissions related to a recent rails/active record zero-day.

Follow each instruction in chronological order for a working installation. Do not skip any numbers.

1. Install rbenv (or RVM) and ruby 1.9.3
2. `ruby scripts/bootstrap.rb`
3. `gem install unicorn` (because it isn't in the gemfile yet)

Running the Server
-------------------

This will start the server with a self-certified ssl certificate. If you need a certified ssl god help you.

1. `unicorn -p 8081`

Development
-----------

You can use [vagrant](http://www.vagrantup.com/) to fire up a development VM with all the neccessary dependencies within. You will get a ready to launch environment (rvm, ruby, bundled gems will be deployed via puppet).

Just run `vagrant up`. Once the VM is running, you can ssh into it via `vagrant ssh`. The code can be found in `/vagrant`, which is shared between your host and the VM. Port 3000 on localhost gets redirected to port 3000 on the development vm, so make sure you're running unicorn (or thin) on the right port.
