ActiveRecord::Base.configurations[:development] = {
  :adapter => 'sqlite3',
  :database => Padrino.root('db', "hacktouch.sqlite3")
}
ActiveRecord::Base.logger = logger
ActiveRecord::Base.establish_connection(ActiveRecord::Base.configurations[Padrino.env])
