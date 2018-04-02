require 'bundler'
Bundler.require
ActiveRecord::Base.establish_connection(
:adapter => "postgresql",
:database => "config/database.yml"
)
require_all 'app'
