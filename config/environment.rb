require 'bundler/setup'
require 'rack-flash'

Bundler.require

configure :development do
  ENV['SINATRA_ENV'] ||= "development"

  ActiveRecord::Base.establish_connection(
     :adapter => "sqlite3",
     :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
   )
end


require_all 'app'
