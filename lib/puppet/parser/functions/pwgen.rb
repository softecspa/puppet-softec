module Puppet::Parser::Functions
  newfunction(:pwgen, :type => :rvalue) do 
    `pwgen -n 12 -s -N 1`.chomp
  end
end
