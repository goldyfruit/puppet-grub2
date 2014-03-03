class grub2::install inherits grub2 {

  if $install_grub {
    package { 'grub2':
      ensure => $::package_ensure,
      name   => $::package_name,
    }

    if $device_install != '' {
      exec { 'Install GRUB':
        command => "${install_binary} ${device_install}",
      }
    }
  }

}
