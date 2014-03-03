# Calculates the device file for the root filesystem
require 'facter'

Facter.add("rootdevice") do
	setcode do
		%x{/bin/mount | egrep 'on\ \/\ ' | awk '{ print $1 }'}.chomp
	end
end
