#
# bool2polarity.rb
# Based on bool2num from PuppetLabs stdlib
#

module Puppet::Parser::Functions
  newfunction(:bool2polarity, :type => :rvalue, :doc => <<-EOS
Converts a boolean to its polarity (affirmation or negation)
Converts the values:
false => no
true => yes
Requires a single boolean as an input.
EOS
  ) do |arguments|

    raise(Puppet::ParseError, "bool2polarity(): Wrong number of arguments " +
      "given (#{arguments.size} for 1)") if arguments.size < 1

    value = arguments[0]
    klass = value.class

    # We can have either true or false
    unless [FalseClass, TrueClass].include?(klass)
      raise(Puppet::ParseError, 'bool2polarity(): Requires a boolean' )
    end

    result = value ? 'yes' : 'no'

    return result
  end
end
