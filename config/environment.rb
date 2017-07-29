1.	require 'bundler'
2.	Bundler.require
3.	ActiveRecord::Base.establish_connection(
4.	:adapter => "sqlite3",
5.	:database => "db/development.sqlite"
6.	)
7.	require_all 'app'
