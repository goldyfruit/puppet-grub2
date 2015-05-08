# class: grub2::install: See README for documentation
class grub2::install inherits grub2 {

  if $grub2::install_grub {
    package { $grub2::package_name:
      ensure => $grub2::package_ensure,
    }

    if $grub2::device_install != '' {
      exec { 'Install GRUB':
        command => "${grub2::install_binary} ${grub2::device_install}",
      }
    }
  }

}
