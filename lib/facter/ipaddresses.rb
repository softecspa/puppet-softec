require 'facter/util/ip'


def not_local(iface)
    local = Regexp.new('^lo')
    if local.match(iface)
        false
    else
        true
    end
end

Facter.add("ipaddresses") do
    ipaddresses = ""
    Facter::Util::IP.get_interfaces.each do |interface|
        if not_local(interface)
            ip = Facter::Util::IP.get_interface_value(interface, 'ipaddress')
            if not ip.nil?
                ipaddresses = ipaddresses + ip +","
            end
        end
    end
    setcode do
        ipaddresses.chomp(",")
    end

    #setcode do
    #    Facter::Util::IP.get_interface_value('eth0', 'ipaddress')
    #end
end 
