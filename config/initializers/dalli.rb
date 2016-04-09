require 'dalli'
options = {:namespace => "NL", :compress => true, :pool_size => 5, :expires_in => 1.hour}
servers = 'localhost:3001'
$cache = Dalli::Client.new(servers, options)
