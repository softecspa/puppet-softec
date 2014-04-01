#
# puppetdb_query.rb
# send a query to puppetdb using local ssl certificate
#

require 'json'

module Puppet::Parser::Functions
  newfunction(:puppetdb_query, :type => :rvalue, :doc => <<-EOS
Send a query to puppetdb
Parameter:
puppetdb url
endpoint (node, fact, resources)
query to send
EOS
  ) do |arguments|
    raise(Puppet::ParseError, "puppetdb_query(): Wrong number of arguments " +
    "given (#{arguments.size} for 3)") if arguments.size < 3

    puppetdb = arguments[0]
    endpoint = arguments[1]
    query    = arguments[2]

    fqdn     = lookupvar('fqdn')
    ssl_base = '/var/lib/puppet/ssl'
    url = "#{puppetdb}/v3/#{endpoint} --data-urlencode 'query=#{query}' --cacert #{ssl_base}/certs/ca.pem --cert #{ssl_base}/certs/#{fqdn}.pem --key #{ssl_base}/private_keys/#{fqdn}.pem"
    output = `curl -G -k #{url}`
    return JSON.load output
  end
end
