# Block requests for php or cgi, jps and what else the people throw at us
Rack::Attack.blocklist('block admin probes') do |req|
  # Request are blocked if the return value is truthy
  block = false
  ["php" , "jsp" , "cgi", "asp", "cfm," "proxy.txt", "soapCaller", "Win32" , "HNAP1" , "w00tw00t",
    "pma" , "mysql" ,"msd" , "MySQL" , "jmx-console" , "ervlet" , "xml" , "cart" ,"install"].each do |no|
    block = true if  req.path.include?(no)
  end
  block
end

# Block requests from people clearly out to break servers
Rack::Attack.blocklist('block admin probes') do |req|
  [ "79.143.82.69" , "85.76.99.50", "127.0.0.1"].include? req.ip
end

# Throttle requests to 5 requests per second per ip
Rack::Attack.throttle('req/ip', :limit => 5, :period => 1.second) do |req|
  # If the return value is truthy, the cache key for the return value
  # is incremented and compared with the limit. In this case:
  #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
  #
  # If falsy, the cache key is neither incremented nor checked.

  req.ip
end

# Always allow requests from shop
# (blacklist & throttles are skipped)
Rack::Attack.safelist('allow in dev and known me') do |req|
  # Requests are allowed if the return value is truthy
  if Rails.env.production?
    [ "85.76.163.53"].include? req.ip
  else
    true
  end
end
