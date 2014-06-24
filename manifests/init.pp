class softec {

  file { '/usr/local/bin/root_device':
    source  => 'puppet:///modules/softec/bin/root_device',
    require => File['/usr/local/lib/bash'],
  }

}
