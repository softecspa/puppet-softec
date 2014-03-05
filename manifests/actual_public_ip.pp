define softec::actual_public_ip(){
    file { ['/etc/facter', '/etc/facter/facts.d']:
        ensure => 'directory',
    }

    file { '/etc/facter/facts.d/actual_public_ip.sh':
        source => "puppet:///modules/softec/actual_public_ip.sh",
        mode    => '0755',
        owner   => 'root',
        group   => 'admin',
    }
}
