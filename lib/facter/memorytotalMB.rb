Facter.add("memorytotalMB") do
    setcode do
        %x{expr `cat /proc/meminfo | grep MemTotal | awk '{print $2}' | bc` / 1024}.chomp
    end
end
