class App < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Assets
  register Padrino::Cache
  enable :caching
  mime_type :woff, 'application/x-font-woff'
end
