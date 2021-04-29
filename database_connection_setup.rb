require './lib/database_connection'

if ENV['RACK_ENV'] == 'test'
  DBConnection.setup('bookmark_manager_test')
else
  DBConnection.setup('bookmark_manager')
end